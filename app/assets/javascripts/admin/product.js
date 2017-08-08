/*Отрисовываем подгруженное изображение*/
var print_product_image = function (id, url) {
    $(document).find('.entity-images-container').find('.row').find('.col-md-2:first')
        .after('<div class="col-md-2 entity-image" data-picture-id="' + id + '"> ' +
            '<a class="btn btn-danger delete-picture" data-remote="true" rel="nofollow" data-method="delete" href="/admin/pictures/'+ id+ '">Удалить </a>' +
            '<img src="' + url + '" class="img-responsive">' +
            '<div class="btn btn-primary set-preview" hidden="false">Сделать обложкой</div>' +
            '</div>');
};

/*Добавляем скрытое поле с id картинки в форму товара*/
var print_image_hidden_tag = function (id) {
    $(document).find('#hidden-tags').append("<input type=\"hidden\" name=\"picture_ids[]\" id=\"picture_ids_" + id + "\" value=\"" + id + "\">");
};

var set_preview = function(current_id){
    var previous_id = $('#product_preview_id').val();
    $('#product_preview_id').val(current_id);
    if (previous_id){
        $(document).find('#preview-tag').remove();
        $(document).find('*[data-picture-id=' + previous_id + ']').find('.set-preview').show();
    }
    $(document).find('*[data-picture-id=' + current_id + ']').find('.set-preview').hide();
    $(document).find('*[data-picture-id=' + current_id + ']').find('.set-preview').before('<span id="preview-tag">Обложка</span>');
};


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
        id: null,
        preview: null,
        pictures_ids: []
    };


/*При загрузке страницы загружаем из хранилища изображения*/
$(document).ready(function () {
    for (var i = 0; i < pictures_data.pictures_ids.length; i++) {
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


Dropzone.autoDiscover = false;
$(document).ready(function () {
    $("#new_picture").dropzone({
        // ограничить размер файла 1 МБ
        maxFilesize: 1,
        // необходимо указать правильно параметр, чтобы он прошел в рельсы
        paramName: "picture[image]",
        // отображать ссылки на удаление в дропзоне
        addRemoveLinks: true,

        success: function (file, response) {
            print_product_image(response.id, response.url);
            /*ОБнолвяем дропзону*/
            $(file.previewTemplate).find('.dz-remove').attr('id', response.id);
            $(file.previewTemplate).addClass('dz-success');
            print_image_hidden_tag(response.id);
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

    $(document).on('click', '.delete-picture', function () {
        var picture_id = $(this).parent().data('picture-id');
        $.ajax({
            type: 'DELETE',
            url: '/admin/pictures/' + picture_id,
            success: function (result) {
                $(document).find('*[data-picture-id=' + result.id + ']').remove();
                if ($('#product_preview_id').val() == result.id){
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