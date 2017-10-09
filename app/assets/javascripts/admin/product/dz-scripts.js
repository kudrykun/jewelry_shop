$(document).ready(function () {
    /*Настройки
    * size_restriction - ограничение на размер изображения в мегабайтах
    * file_extensions - доступные для загрузки расширения файлов. Писать в нижнем регистре. Jpeg и jpg писать в паре.
    * rails_pictures_path - строка, содержит рельсовский путь до картинок*/

    var file_size_restriction = 3; //mb
    var permitted_file_extensions = ['jpg', 'jpeg', 'png'];
    var rails_pictures_path = '/admin/pictures/';

    /*Инициализация
    * current_domain - строка с текущими протоколом и доменным именем
    * entity_id - строка с id текущей сущности, например с id товара
    * rails_entity_path - строка, содержит рельсовский путь до сущности, к кторой привязывать картинки нужно
    * _URL - ХЗ, я глупенький, но это нужно
    * $dropzone - переменная с первой дропзоной (ну как бы, она должна быть одна, другие игнорятся, увы)
    * pictures_size - текущее количество картинок*/

    var current_domain = $(document).attr('URL').match(/(http|https):\/\/([^\/]*)/)[0];
    var entity_id = $(document).attr('URL').match(/\/([\d]+)\//)[1];
    var rails_entity_path = $('form').attr('action').replace(entity_id,'');
    var _URL = window.URL || window.webkitURL;
    var $dropzone = $('.dropzone').first();
    var pictures_size = $dropzone.find(".dz-image-container").length;



    /*Drag and drop
    * обработчик dragenter - при перетаскивании чего либо в дропзону.
    * обработчик dragleave - после dragenter, при покидании дропзоны.
    * обработчик drop - помещение файлов в дропзону. Визуальные изменения и загрузка файлов.
    * обработчик dragover - хз, нужен ли он здесь*/
    {
        $dropzone.on('dragenter', function () {
            $dropzone.addClass("highlightDropArea");
        });

        $dropzone.on('dragleave', function () {
            $dropzone.removeClass("highlightDropArea");
        });

        $dropzone.on('drop', function (ev) {
            //Отключает дефолтные события, но это точно предотвращает открытие картинки в браузере
            ev.preventDefault();
            ev.stopPropagation();

            // итерация через загружаемые файлы
            if (ev.originalEvent.dataTransfer) {
                if (ev.originalEvent.dataTransfer.files.length) {
                    var droppedFiles = ev.originalEvent.dataTransfer.files;
                    var promises = [];
                    upload_files(droppedFiles, promises);
                    $dropzone.addClass("dz-started");
                }
            }
            $dropzone.removeClass("highlightDropArea");
            return false;
        });

        $dropzone.on('dragover', function (ev) {
            ev.preventDefault();
            ev.stopPropagation();
        });
    }


    /*Загрузка кликом
    * обработчик $dropzone.click - происходит при клике на свободное место дропзоны,
    *   caption игнорируется. Запускает клик по скрытому файловому полю, тем самым открывая диалоговое окно
    * обработчик input on change - при подтверждениии выбора файлов в диалоговом окне.
    *   Загружает файлы, визуально изменяет дропзону.*/
    {
        $dropzone.click(function () {
            $('input[type=file]').click();
        });

        $('input[type=file]').on('change', function () {
            if ($(this).get(0).files.length > 0) {
                var droppedFiles = $(this).get(0).files;
                var promises = [];
                upload_files(droppedFiles, promises);
                $('#dzHiddenInput').val('');
                $dropzone.addClass("dz-started");
            }
            $dropzone.removeClass("highlightDropArea");
        });
    }


    /*Управление
    * обработчик click .dz-delete-btn - удаляет изображения и перевыбирает превью
    * обработчик click .dz-preview-btn - устанавливает превью
    * обработчик click .dz-image-container - отключает вызов диалогового окна при клике на изображение*/
    {
        $dropzone.on('click', ".dz-delete-btn", function () {
            if (confirm("Вы уверены что хотите удалить фото?")) {
                var id = $(this).closest('.dz-image').attr('data-picture-id'); //id удаляемого товара
                var del = $(this).closest('.dz-image'); //удаляемое изображение

                if (del.hasClass('dz-preview')) { //если этот элемент превью
                    if (pictures_size == 1) { //если картинка последняя
                        del.closest(".dz-image-container").fadeOut(400, function () {
                            $(this).remove(); //удаялем элемент
                            set_preview('null');
                        });
                        /*После удаления последней картинки, возвращаем caption*/
                        $dropzone.removeClass("dz-started");
                    }
                    else { //если нет
                        del.closest(".dz-image-container").fadeOut(400, function () {
                            $(this).remove(); //удаялем элемент
                            $dropzone.find('.dz-image').first().addClass('dz-preview');  //делаем первое изображение в дропзону превьюхой
                            set_preview($dropzone.find('.dz-image').first().attr('data-picture-id'));
                        });
                    }
                }
                else { //не превью
                    del.closest(".dz-image-container").fadeOut(400, function () {
                        $(this).remove(); //удаялем элемент
                    });
                }

                //Удаляем картинку с сервера
                $.ajax({
                    url: current_domain + rails_pictures_path + id,
                    type: 'DELETE'
                });

                pictures_size--;
                return false;
                /*предотвращает запуск события родителя*/

            }
        });

        $dropzone.on('click', ".dz-preview-btn", function () {
            $('.dz-preview').removeClass('dz-preview');
            $(this).closest(".dz-image").addClass('dz-preview');
            set_preview($(this).closest(".dz-image").attr('data-picture-id'));
            return false;
            /*предотвращает запуск события родителя*/
        });

        $dropzone.on('click', ".dz-image-container", function (ev) {
            ev.preventDefault();
            ev.stopPropagation();
        });
    }


    /*Функции
    * upload_files(droppedFiles, promises) - загружает изображения на сервер, присваивает товару и отображает их в дропзоне
    * set_preview(value) - ajax запрос, отправляющий в сервер id превью
    * print_template(size, name) - рисует обертку будущего изображения
    * isFileValid(file_size, file_name) - определяет валидность файла по имени и размеру файла*/
    {

        var upload_files = function (droppedFiles, promises) {
            for (var i = 0; i < droppedFiles.length; i++) {
                if (isFileValid(droppedFiles[i].size, droppedFiles[i].name)) {
                    console.log(droppedFiles[i]);
                    var image = new Image();
                    /*Важно*/
                    image.onload = temp(image, droppedFiles[i].size, droppedFiles[i].name, i);

                    function temp(image, size, name, index) {

                        print_template(size, name);

                        $dropzone.find(".dz-image").last().append(image);
                        /*Добавляем изображение в контейнер*/
                        $(image).addClass("img-responsive");

                        var file_data = droppedFiles[index];   // Получаем файл
                        var form_data = new FormData();    // создаем объект с файломи его свойствами
                        form_data.append("picture[image]", file_data); // добавляем его в параметры
                        var request = $.ajax({
                            url: current_domain + rails_pictures_path,
                            data: form_data,
                            dataType: 'json',
                            type: 'POST',
                            processData: false, // это очень важно для работы form data
                            contentType: false, // это очень важно для работы form data
                            success: function (result) {
                                pictures_size++;
                                image.src = result.url; // ставим новый адрес картинки, тот что получили от сервера
                                $(image).closest('.dz-image').attr('data-picture-id', result.id);
                                /*добавляем атрибут с id родителя*/
                                /*Этим"ajax-ом привязывает картинку к товару*/
                                $.ajax({
                                    url: current_domain + rails_entity_path + entity_id,
                                    data: {
                                        product: {
                                            picture_id: result.id
                                        }
                                    },
                                    dataType: 'json',
                                    type: 'PATCH'
                                });
                            }
                        });
                        promises.push(request);
                        /*По идее, это не позволяет двум ajax-ам выполнятся одновременно*/

                    }

                    image.src = _URL.createObjectURL(droppedFiles[i]);
                }
            }
            $.when.apply(null, promises).done(function () {
                if (pictures_size == promises.length) {
                    $(".dz-image").first().addClass('dz-preview');
                    set_preview($dropzone.find('.dz-preview').first().attr('data-picture-id'));
                }
            });
        };

        var set_preview = function (value) {
            $.ajax({
                url: current_domain + rails_entity_path + entity_id,
                data: {
                    product: {
                        preview_id: value
                    }
                },
                dataType: 'json',
                type: 'PATCH'
            });
        };

        var print_template = function(size, name){
            $("#droppedImages .row").append(
                '<div class="col-xs-12 col-sm-6 col-md-3 dz-image-container">' +
                    '<div class="dz-image">' +
                        '<div class="dz-preview-btn" data-toggle="tooltip" data-placement="top" data-original-title="Нажмите, чтобы сделать превью">' +
                            '<i class="fa fa-thumb-tack pin" aria-hidden="true"></i>' +
                        '</div>' +
                        '<div class="dz-delete-btn" data-toggle="tooltip" data-placement="top" data-original-title="Удалить">' +
                            '<i class="fa fa-times pin" aria-hidden="true"></i>' +
                        '</div>' +
                        '<div class="dz-details">' +
                            '<div class="dz-size">' + Math.round(size / 1024) + ' kB</div>' +
                            '<div class="dz-name">' + name + '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>'
            );
        };

        var isFileValid = function (file_size, file_name) {
            var extension = file_name.split('.').pop().toLowerCase();
            var restriction_in_bytes = file_size_restriction * 1024 * 1024;
            var extension_permitted = (permitted_file_extensions.indexOf(extension) != -1);
            var size_permitted = (file_size <= restriction_in_bytes);
            if (extension_permitted && size_permitted) {
                return true;
            }
            else {
                alert("Ограничение на размер файла: " + file_size_restriction + " Mб");
                return false;
            }
        };
    }
});