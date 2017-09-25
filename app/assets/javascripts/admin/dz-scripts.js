

$(document).ready(function(){
    /*Инициализация количества картинок*/
    function pic_size(){
        var size = $("#myDropzone").find(".dz-image-container").length;
        if (size != 0) {
            return size;
        }else {
            return 0;
        }
    };
    /*счетчик картинок*/
    var pictures_size = pic_size();
    var current_domain = $(document).attr('URL').match(/http:\/\/([^\/]*)/)[0];
    var _URL = window.URL || window.webkitURL;

    /****************************************************/
    /***************ПЕРЕТАСКИВАНИЕ***********************/
    /****************************************************/

    /*dragenter - событие, которое срабатывает при перемещении чего либо в дропзону*/
    $("#myDropzone").on('dragenter', function(ev) {
        $("#myDropzone").addClass("highlightDropArea");
    });

    /*dragenter - событие, которое срабатывает при покидании файлом дропзоны*/
    $("#myDropzone").on('dragleave', function(ev) {
        $("#myDropzone").removeClass("highlightDropArea");
    });

    /*drop - событие, срабатывающее при "опускании" файла в дропзону*/
    $("#myDropzone").on('drop', function(ev) {
        //Отключает дефолтные события, но это точно предотвращает открытие картинки в браузере
        ev.preventDefault();
        ev.stopPropagation();

        // итерация через фзагружаемые файлы
        if(ev.originalEvent.dataTransfer){
            if(ev.originalEvent.dataTransfer.files.length) {
                var droppedFiles = ev.originalEvent.dataTransfer.files;

                var promises = [];/*По идее, это не позволяет двум ajax-ам выполнятся одновременно*/

                for(var i = 0; i < droppedFiles.length; i++)
                {
                    var flag = false;
                    if (pictures_size === 0)
                        flag = true;
                    console.log(droppedFiles[i]);
                    var image = new Image();
                    /*Важно*/
                    image.onload = a(image,droppedFiles[i].size, droppedFiles[i].name);
                    function a(image,size, name) {
                        $("#droppedImages .row").append(
                            '<div class="col-xs-12 col-sm-6 col-md-3 dz-image-container">' +
                            '<div class="dz-image">' +
                            '<div class="dz-preview-btn" data-toggle="tooltip" data-placement="top" data-original-title="Нажмите, чтобы сделать превью">' +
                            '<i class="fa fa-thumb-tack pin" aria-hidden="true"></i>'+
                            '</div>' +
                            '<div class="dz-delete-btn" data-toggle="tooltip" data-placement="top" data-original-title="Удалить">' +
                            '<i class="fa fa-times pin" aria-hidden="true"></i>'+
                            '</div>' +
                            '<div class="dz-details">' +
                            '<div class="dz-size">' + Math.round(size / 1024) + ' kB</div>' +
                            '<div class="dz-name">' + name + '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>'
                        );

                        $("#droppedImages > .row > div > .dz-image").last().append(image);/*Добавляем изображение в контейнер*/
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
                                $(image).closest('.dz-image').attr('data-picture-id', result.id); /*добавляем атрибут с id родителя*/
                                /*Этим"ajax-ом привязывает картинку к товару*/
                                $.ajax({
                                    url: current_domain + '/admin/products/' + window.location.href.match(/\/([\d]+)\//)[1],
                                    data: {
                                        product:{
                                            picture_id: result.id
                                        }
                                    },
                                    dataType: 'json',
                                    type: 'PATCH'
                                });
                            }
                        });
                        promises.push( request);/*По идее, это не позволяет двум ajax-ам выполнятся одновременно*/

                    }
                    image.src = _URL.createObjectURL(droppedFiles[i]);




                }
                $.when.apply(null, promises).done(function(result){/*По идее, это не позволяет двум ajax-ам выполнятся одновременно*/
                    if (pictures_size == promises.length) {
                        $(".dz-image").first().addClass('dz-preview');
                        $.ajax({
                            url: current_domain + '/admin/products/' + window.location.href.match(/\/([\d]+)\//)[1],
                            data: {
                                product: {
                                    preview_id: $('#myDropzone').find('.dz-preview').first().attr('data-picture-id')
                                }
                            },
                            dataType: 'json',
                            type: 'PATCH'
                        });
                    }
                })
            }
        }
        /*Добавляем класс, скрывающий caption*/
        $("#myDropzone").addClass("dz-started");
        $("#myDropzone").removeClass("highlightDropArea");
        return false;
    });

    $("#myDropzone").on('dragover', function(ev) {
        ev.preventDefault();
        ev.stopPropagation();
    });


    /****************************************************/
    /***************КЛИК*********************************/
    /****************************************************/

    /*клик на дрозоне*/
    $("#myDropzone").click(function(ev) {
        /*Вызов клика по файловому полю*/
        $('input[type=file]').click();
    });
    /*Функция обработки клика*/
    $('input[type=file]').click(function(e){
    });

    /*Здесь возможно будет функция обработки файлов*/
    $('input[type=file]').on('change',function(e){
        if ($(this).get(0).files.length > 0) {
            var droppedFiles = $(this).get(0).files;
            var promises = [];/*По идее, это не позволяет двум ajax-ам выполнятся одновременно*/
            for(var i = 0; i < droppedFiles.length; i++)
            {
                console.log(droppedFiles[i]);
                var image = new Image();
                image.onload = a(image,droppedFiles[i].size, droppedFiles[i].name);
                function a(image,size, name) {
                    $("#droppedImages .row").append(
                        '<div class="col-xs-12 col-sm-6 col-md-3 dz-image-container">' +
                        '<div class="dz-image">' +
                        '<div class="dz-preview-btn"  data-toggle="tooltip" data-placement="top" data-original-title="Нажмите, чтобы сделать превью" >' +
                        '<i class="fa fa-thumb-tack pin" aria-hidden="true"></i>'+
                        '</div>' +
                        '<div class="dz-delete-btn" data-toggle="tooltip" data-placement="top" data-original-title="Удалить">' +
                        '<i class="fa fa-times pin" aria-hidden="true"></i>'+
                        '</div>' +
                        '<div class="dz-details">' +
                        '<div class="dz-size">' + Math.round(size / 1024) + ' KB</div>' +
                        '<div class="dz-name">' + name + '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>'
                    );
                    $("#droppedImages > .row > div > .dz-image").last().append(image);
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
                            image.src = result.url; // ставим новый адрес картинки, тот что получили от сервера
                            $(image).closest('.dz-image').attr('data-picture-id', result.id); /*добавляем атрибут с id родителя*/
                            /*Этим"ajax-ом привязывает картинку к товару*/
                            $.ajax({
                                url: current_domain + '/admin/products/' + window.location.href.match(/\/([\d]+)\//)[1],
                                data: {
                                    product:{
                                        picture_id: result.id
                                    }
                                },
                                dataType: 'json',
                                type: 'PATCH',
                                success: function () {
                                    alert('q');

                                }
                            });
                        }
                    });
                    /*if(pictures_size === 0) {
                        alert('1488');
                        $(".dz-image").addClass('dz-preview');
                        $.ajax({
                            url: current_domain + '/admin/products/' + window.location.href.match(/\/([\d]+)\//)[1],
                            data: {
                                product:{
                                    preview_id: $('#myDropzone').find('.dz-preview').attr('data-picture-id')
                                }
                            },
                            dataType: 'json',
                            type: 'PATCH'
                        });

                    }*/
                    promises.push( request);/*По идее, это не позволяет двум ajax-ам выполнятся одновременно*/
                }
                image.src = _URL.createObjectURL(droppedFiles[i]);

                pictures_size++;
            }
            $.when.apply(null, promises).done(function(){/*По идее, это не позволяет двум ajax-ам выполнятся одновременно*/
            })
            $('#dzHiddenInput').val('')
            $("#myDropzone").addClass("dz-started");
        }
        $("#myDropzone").removeClass("highlightDropArea");
    });



    /****************************************************/
    /***************УПРАВЛЕНИЕ***************************/
    /****************************************************/

    /*Удаление картинки*/
    $("#myDropzone").on('click',".dz-delete-btn", function(e){
        var id = $(this).closest('.dz-image').attr('data-picture-id'); //id удаляемого товара
        var del = $(this).closest('.dz-image'); //удаляемое изображение

        if( del.hasClass('dz-preview')) { //если этот элемент превью
            if (pictures_size == 1) { //если картинка последняя
                del.closest(".dz-image-container").fadeOut(400,function(){
                    $(this).remove(); //удаялем элемент
                    $.ajax({ //обнуляем preview_id
                        url: current_domain + '/admin/products/' + window.location.href.match(/\/([\d]+)\//)[1],
                        data: {
                            product:{
                                preview_id: 'null'
                            }
                        },
                        dataType: 'json',
                        type: 'PATCH'
                    });
                });
                /*После удаления последней картинки, возвращаем caption*/
                $("#myDropzone").removeClass("dz-started");
            }
            else { //если нет
                del.closest(".dz-image-container").fadeOut(400,function(){
                    $(this).remove(); //удаялем элемент
                    $('#myDropzone').find('.dz-image').first().addClass('dz-preview');  //делаем первоеизображение в дропзону превьюхой
                    $.ajax({ //обнуляем preview_id
                        url: current_domain + '/admin/products/' + window.location.href.match(/\/([\d]+)\//)[1],
                        data: {
                            product:{
                                preview_id: $('#myDropzone').find('.dz-image').first().attr('data-picture-id')
                            }
                        },
                        dataType: 'json',
                        type: 'PATCH'
                    });
                });
            }
        }
        else { //не превью
            del.closest(".dz-image-container").fadeOut(400,function(){
                $(this).remove(); //удаялем элемент
            });
        }

        //Удаляем картинку с сервера
        $.ajax({
            url: current_domain + '/admin/pictures/' + id,
            type: 'DELETE',
        });

        pictures_size--;
        return false;/*предотвращает запуск события родителя*/
    });

    /*Выбор превью*/
    $("#myDropzone").on('click',".dz-preview-btn", function(e){
        $('.dz-preview').removeClass('dz-preview');
        $(this).closest(".dz-image").addClass('dz-preview');
        $.ajax({
            url: current_domain + '/admin/products/' + window.location.href.match(/\/([\d]+)\//)[1],
            data: {
                product:{
                    preview_id: $(this).closest(".dz-image").attr('data-picture-id')
                }
            },
            dataType: 'json',
            type: 'PATCH'
        });
        return false;/*предотвращает запуск события родителя*/
    });




});



