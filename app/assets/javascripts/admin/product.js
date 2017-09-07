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

/*ИНИЦИАЛИЗАЦИЯ ДАННЫХ ДЛЯ STORAGE TITLE*/
/*id текущего товара*/
var product_id;
/*Переменная под имя объекта в session storage*/
var storage_title;
/*Если в ссылке на текущий товар есть id, то сохраняем его и используем в качестве имени объекта*/
if (window.location.href.match(/\/([\d]+)\//)) {
    product_id = window.location.href.match(/\/([\d]+)\//)[1];
    storage_title = '_' + product_id;
} else {
    storage_title = '';
}
/*Инициализируем объект для session storage. Инициализируем уже имеющимся объектом, иначе инициализируем новый пустой объект*/
var pictures_data = JSON.parse(sessionStorage.getItem("pictures_data" + storage_title)) || {
        preview: null,
        pictures_ids: []
    };

/*При загрузке страницы загружаем из хранилища изображения*/
$(document).ready(function () {
    /*Для каждого изображения отрисовываем его вьюху и добавляем скрытый тег
    *Если изображение уже отрисовано, то не делаем ничего
    * При наличии в хранилище id превью - устанавливаем и его*/
    for (var i = 0; i < pictures_data.pictures_ids.length; i++) {
        if (!($(document).find('#picture_ids_' + pictures_data.pictures_ids[i]).length))
            $.ajax('/admin/pictures/' + pictures_data.pictures_ids[i], {
                contentType: 'application/json',
                dataType: 'json',
                success: function (result) {
                    print_product_image(result.picture_id, result.url);
                    print_image_hidden_tag(result.picture_id);
                    if (pictures_data.preview) {
                        set_preview(pictures_data.preview);
                    }
                }
            });

    }
});


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
            //обновляем не дропзону
            print_product_image(response.id, response.url);
            print_image_hidden_tag(response.id);
            /*ОБнолвяем дропзону*/
            $(file.previewTemplate).find('.dz-remove').attr('id', response.id);
            $(file.previewTemplate).addClass('dz-success');

            /*Добавляем новое значение в массив и отправляем его в session storage*/
            pictures_data.pictures_ids.push(response.id);
            sessionStorage.setItem('pictures_data' + storage_title, JSON.stringify(pictures_data));
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
                    $(document).find('*[data-picture-id=' + id + ']').remove();
                    $(document).find('#picture_ids_' + id).remove();
                    $('#product_preview_id').val('undefined');

                    pictures_data.preview = null;
                    /*Удалем значение из массива и отправляем его в session storage*/
                    var index = pictures_data.pictures_ids.indexOf(+id)
                    if (index != -1) {
                        pictures_data.pictures_ids.splice(index, 1);
                    }
                    sessionStorage.setItem('pictures_data' + storage_title, JSON.stringify(pictures_data));
                }
            });
        }
    });

    /*Установка id картинки, которая будет обложкой в скрытое поле*/
    $(document).on('click', '.set-preview', function () {
        var currentId = $(this).parent().data('picture-id');
        set_preview(currentId);

        pictures_data.preview = currentId;
        sessionStorage.setItem('pictures_data' + storage_title, JSON.stringify(pictures_data));
    });

    /*Удаление картинки*/
    $(document).on('click', '.delete-picture', function () {
        var picture_id = $(this).parent().data('picture-id');
        $.ajax({
            type: 'DELETE',
            url: '/admin/pictures/' + picture_id,
            success: function (result) {
                $(document).find('*[data-picture-id=' + result.id + ']').remove();

                if ($('#product_preview_id').val() == result.id) {
                    $('#product_preview_id').val('undefined');
                    pictures_data.preview = null;
                }
                var index = pictures_data.pictures_ids.indexOf(+result.id)
                if (index != -1) {
                    pictures_data.pictures_ids.splice(index, 1);
                }
                sessionStorage.setItem('pictures_data' + storage_title, JSON.stringify(pictures_data));
            }
        });
    });
});