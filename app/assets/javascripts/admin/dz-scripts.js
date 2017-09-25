$(document).ready(function () {
    /*Инициализация
    * pictures_size - текущее количество картинок
    * current_domain - строка с текущими протоколом и доменным именем
    * entity_id - строка с id текущей сущности, например с id товара
    * _URL - ХЗ, я глупенький, но это нужно
    *
    * pic_size() - устанавливает количество картинок, ища их в загруженной дропзоне*/

    var pictures_size = pic_size();
    var current_domain = $(document).attr('URL').match(/http:\/\/([^\/]*)/)[0];
    var entity_id = $(document).attr('URL').match(/\/([\d]+)\//)[1]
    var _URL = window.URL || window.webkitURL;

    function pic_size() {
        var size = $("#myDropzone").find(".dz-image-container").length;
        if (size != 0) {
            return size;
        } else {
            return 0;
        }
    };




    /*Drag and drop
    * обработчик dragenter - при перетаскивании чего либо в дропзону.
    * обработчик dragleave - после dragenter, при покидании дропзоны.
    * обработчик drop - помещение файлов в дропзону. Визуальные изменения и загрузка файлов.
    * обработчик dragover - хз, нужен ли он здесь*/
    {
        $("#myDropzone").on('dragenter', function () {
            $("#myDropzone").addClass("highlightDropArea");
        });

        $("#myDropzone").on('dragleave', function () {
            $("#myDropzone").removeClass("highlightDropArea");
        });

        $("#myDropzone").on('drop', function (ev) {
            //Отключает дефолтные события, но это точно предотвращает открытие картинки в браузере
            ev.preventDefault();
            ev.stopPropagation();

            // итерация через загружаемые файлы
            if (ev.originalEvent.dataTransfer) {
                if (ev.originalEvent.dataTransfer.files.length) {
                    var droppedFiles = ev.originalEvent.dataTransfer.files;
                    var promises = [];
                    upload_files(droppedFiles, promises);
                    $("#myDropzone").addClass("dz-started");
                }
            }
            $("#myDropzone").removeClass("highlightDropArea");
            return false;
        });

        $("#myDropzone").on('dragover', function (ev) {
            ev.preventDefault();
            ev.stopPropagation();
        });
    }




    /*Загрузка кликом
    * обработчик $("#myDropzone").click - происходит при клике на свободное место дропзоны,
    *   caption игнорируется. Запускает клик по скрытому файловому полю, тем самым открывая диалоговое окно
    * обработчик input on change - при подтверждениии выбора файлов в диалоговом окне.
    *   Загружает файлы, визуально изменяет дропзону.*/
    {
        $("#myDropzone").click(function () {
            $('input[type=file]').click();
        });

        $('input[type=file]').on('change', function () {
            if ($(this).get(0).files.length > 0) {
                var droppedFiles = $(this).get(0).files;
                var promises = [];
                upload_files(droppedFiles, promises);
                $('#dzHiddenInput').val('')
                $("#myDropzone").addClass("dz-started");
            }
            $("#myDropzone").removeClass("highlightDropArea");
        });
    }




    /*Управление
    * обработчик click .dz-delete-btn - удаляет изображения и перевыбирает превью
    * обработчик click .dz-preview-btn - устанавливает превью*/
    {
        $("#myDropzone").on('click', ".dz-delete-btn", function () {
            var id = $(this).closest('.dz-image').attr('data-picture-id'); //id удаляемого товара
            var del = $(this).closest('.dz-image'); //удаляемое изображение

            if (del.hasClass('dz-preview')) { //если этот элемент превью
                if (pictures_size == 1) { //если картинка последняя
                    del.closest(".dz-image-container").fadeOut(400, function () {
                        $(this).remove(); //удаялем элемент
                        set_preview('null');
                    });
                    /*После удаления последней картинки, возвращаем caption*/
                    $("#myDropzone").removeClass("dz-started");
                }
                else { //если нет
                    del.closest(".dz-image-container").fadeOut(400, function () {
                        $(this).remove(); //удаялем элемент
                        $('#myDropzone').find('.dz-image').first().addClass('dz-preview');  //делаем первое изображение в дропзону превьюхой
                        set_preview($('#myDropzone').find('.dz-image').first().attr('data-picture-id'));
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
                url: current_domain + '/admin/pictures/' + id,
                type: 'DELETE',
            });

            pictures_size--;
            return false;
            /*предотвращает запуск события родителя*/
        });


        $("#myDropzone").on('click', ".dz-preview-btn", function () {
            $('.dz-preview').removeClass('dz-preview');
            $(this).closest(".dz-image").addClass('dz-preview');
            set_preview($(this).closest(".dz-image").attr('data-picture-id'));
            return false;
            /*предотвращает запуск события родителя*/
        });
    }



    /*Функции
    * upload_files(droppedFiles, promises) - загружает изображения на сервер, присваивает товару и отображает их в дропзоне
    * set_preview(value) - ajax запрос, отправляющий в сервер id превью
    * print_template() - рисует обертку будущего изображения*/
    {

        var upload_files = function (droppedFiles, promises) {
            for (var i = 0; i < droppedFiles.length; i++) {
                console.log(droppedFiles[i]);
                var image = new Image();
                /*Важно*/
                image.onload = a(image, droppedFiles[i].size, droppedFiles[i].name);

                function a(image, size, name) {

                    print_template();

                    $("#droppedImages > .row > div > .dz-image").last().append(image);
                    /*Добавляем изображение в контейнер*/
                    $(image).addClass("img-responsive");

                    var file_data = droppedFiles[i];   // Получаем файл
                    var form_data = new FormData();    // создаем объект с файломи его свойствами
                    form_data.append("picture[image]", file_data); // добавляем его в параметры
                    var request = $.ajax({
                        url: current_domain + '/admin/pictures',
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
                                url: current_domain + '/admin/products/' + entity_id,
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
            $.when.apply(null, promises).done(function (result) {/*По идее, это не позволяет двум ajax-ам выполнятся одновременно*/
                if (pictures_size == promises.length) {
                    $(".dz-image").first().addClass('dz-preview');
                    set_preview($('#myDropzone').find('.dz-preview').first().attr('data-picture-id'));
                }
            });
        }

        var set_preview = function(value){
            $.ajax({
                url: current_domain + '/admin/products/' + entity_id,
                data: {
                    product: {
                        preview_id: value
                    }
                },
                dataType: 'json',
                type: 'PATCH'
            });
        }

        var print_template = function(){
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
        }
    }
});