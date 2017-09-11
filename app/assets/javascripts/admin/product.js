/*Етот скрипт написан 08.08.2017 и отвечает за поведение картинок в товаре.
* Во-первых, он отвечает за загрузку и удаление картинок через окно dropzone js.
* Во-вторых, он отвеает за отрисовку и удаление загруженных картинок в основной
* части страницы создания\редактирования товара.
* В-четвертых, он отвечает за выбор превью из загруженных картинок.
* И в-пятых, он отвечает за подгрузку изображений, которые были загружены, но не сохранены вместе с товаром.
*
* Есть подгрузка для создания товара и редактирования товара.
* Главное между ними различие в имени, под которым хранятся объекты с данными о картинках в sessionStorage
* В случае создания товара, в sessionStorage хранится один объект под именем pictures_data.
* В случае реадактирования товара, для каждого товара хранится объект pictures_data_\\айди-товара\\
* Структура pictures_data проста: id превью и массив с id изображений*/

/*ФУНКЦИИ ОТРИСОВКИ ИЗМЕНЕНИЙ В КАРТИНКАХ*/

/*Отрисовываем подгруженное изображение*/
var print_product_image = function (id, url) {
    $(document).find('.entity-images-container').find('.row').find('.col-md-2:first')
        .after('<div class="col-md-2 entity-image" data-picture-id="' + id + '"> ' +
            '<a class="btn btn-danger delete-picture" data-remote="true" rel="nofollow" data-method="delete" href="/admin/pictures/' + id + '">Удалить </a>' +
            '<img src="' + url + '" class="img-responsive">' +
            '<div class="btn btn-primary set-preview" hidden="false">Сделать обложкой</div>' +
            '</div>');
};

/*Добавляем скрытое поле с id картинки в форму товара*/
var print_image_hidden_tag = function (id) {
    $(document).find('#hidden-tags').append("<input type=\"hidden\" name=\"picture_ids[]\" id=\"picture_ids_" + id + "\" value=\"" + id + "\">");
};

/*Отрисовываем изменение прьвьюхи*/
var set_preview = function (current_id) {
    //берем id предыдущей превьюхи
    var previous_id = $('#product_preview_id').val();
    //утсанавливаем новое значение превьюхи
    $('#product_preview_id').val(current_id);
    //если id предыдущей превьюхи есть, то удаляем у старого превью все, что говорит о том, что он превью
    if (previous_id) {
        $(document).find('#preview-tag').remove();
        $(document).find('*[data-picture-id=' + previous_id + ']').find('.set-preview').show();
    }
    //убираем кнопку и ставим обозначение, что это теперь превью
    $(document).find('*[data-picture-id=' + current_id + ']').find('.set-preview').hide();
    $(document).find('*[data-picture-id=' + current_id + ']').find('.set-preview').before('<span id="preview-tag">Обложка</span>');
};



/*#TODO ВАЖНО!*/
/*ФУНКЦИИ DROPZONE И ФУНКЦИИ ИЗМЕНЕНИЙ КАРТИНОК*/
Dropzone.autoDiscover = false;
$(document).ready(function () {
    $("#new_picture").dropzone({
        // ограничить размер файла 1 МБ
        maxFilesize: 1,
        // необходимо указать правильно параметр, чтобы он прошел в рельсы
        paramName: "picture[image]",
        // отображать ссылки на удаление в дропзоне
        addRemoveLinks: true,
        // опции перевода
        dictDefaultMessage: "Перетащите изображения сюда или кликните для загрузки",
        dictFallbackMessage: "Ваш браузер не поддерживает функцию загрузки файлов перетаскиванием",
        dictFileTooBig: "Файл слишком большой ({{filesize}} МБ). Максимальный размер файла: {{maxFilesize}} МБ.",
        dictInvalidFileType: "Вы не можете загрузить файл этого формата",
        dictResponseError: "Сервер ответил ошибкой ({{statusCode}})",
        dictCancelUpload: "Отменить загрузку",
        dictCancelUploadConfirmation: "Вы уверены, что хотите отменить загрузку этого файла?",
        dictRemoveFile: "Удалить файл",
        success: function (file, response) {
            /*ОБнолвяем дропзону*/
            $(file.previewTemplate).find('.dz-remove').attr('id', response.id);
            $(file.previewTemplate).addClass('dz-success');

            //обновляем не дропзону
            print_product_image(response.id, response.url);/*Добавляем изображение и его кнопки*/
            print_image_hidden_tag(response.id); /*Добавляем скрытый тег в форму*/
        },

        removedfile: function (file) {
            var id = $(file.previewTemplate).find('.dz-remove').attr('id');
            $.ajax({
                type: 'DELETE',
                url: '/admin/pictures/' + id,
                success: function (data) {
                    console.log(data.message);
                    file.previewElement.remove();

                    //обновляем не дропзону
                    $(document).find('*[data-picture-id=' + id + ']').remove(); /*удаление изображения и кнопок*/
                    $(document).find('#picture_ids_' + id).remove(); /*удаление скрытого тега*/
                    if ($('#product_preview_id').val() == id) {
                        $('#product_preview_id').val('undefined');
                    }
                }
            });
        }
    });

    /*Установка id картинки, которая будет обложкой в скрытое поле*/
    $(document).on('click', '.set-preview', function () {
        var currentId = $(this).parent().data('picture-id');
        set_preview(currentId);
    });

    /*Удаление картинки*/
    $(document).on('click', '.delete-picture', function () {
        var picture_id = $(this).parent().data('picture-id');
        $.ajax({
            type: 'DELETE',
            url: '/admin/pictures/' + picture_id,
            success: function (result) {
                $(document).find('*[data-picture-id=' + result.id + ']').remove();/*удаление изображения и кнопок*/
                $(document).find('#picture_ids_' + result.id).remove(); /*удаление скрытого тега*/
                if ($('#product_preview_id').val() == result.id) {
                    $('#product_preview_id').val('undefined');
                }
            }
        });
        $('#new_picture').dropzone.removeFile
    });
});