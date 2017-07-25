// disable auto discover
Dropzone.autoDiscover = false;
$(document).ready(function(){
    // grap our upload form by its id
    $("#new_picture").dropzone({
        // restrict image size to a maximum 1MB
        maxFilesize: 1,
        // changed the passed param to one accepted by
        // our rails app
        paramName: "picture[image]",
        // show remove links on each image upload
        addRemoveLinks: true,

        success: function(file, response) {
            $(document).find('.entity-images-container').find('.row').find('.col-md-2:first')
                .after('<div class="col-md-2 entity-image" data-picture-id="' + response.id + '"> ' +
                            '<a class="btn btn-danger delete-picture" data-remote="true" rel="nofollow" data-method="delete" href="/admin/pictures/157">Удалить </a>'+
                            '<img src="' + response.url + '" class="img-responsive">' +
                            '<div class="btn btn-primary set-preview" hidden="false">Сделать обложкой</div>' +
                        '</div>');
            $(file.previewTemplate).find('.dz-remove').attr('id',response.id);
            $(file.previewTemplate).addClass('dz-success');
            $(document).find('#hidden-tags').append("<input type=\"hidden\" name=\"picture_ids[]\" id=\"picture_ids_" + response.id + "\" value=\"" + response.id + "\">");
        },

        removedfile: function(file){
            var id = $(file.previewTemplate).find('.dz-remove').attr('id');

            $.ajax({
               type: 'DELETE',
               url: '/admin/pictures/' + id,
               success: function(data){
                   console.log(data.message);
                   file.previewElement.remove();
                   $(document).find('*[data-picture-id=' + id + ']').remove();
                   $(document).find('#picture_ids_' + id).remove();
               }
            });
        }
    });
    /*Установка id картинки, которая будет обложкой в скрытое поле*/
    $(document).on('click','.set-preview',function(){
        /*Извлекает старое id обложки из скрытого поля*/
        var previous_preview = $('#product_preview_id').val();
        /*Забирает новое id обложки из data-аттрибута дива выбранной картинки*/
        var preview_id = $(this).parent().data('picture-id');
        $('#product_preview_id').val(preview_id);

        /*Устанавливает надпись "Обложка" у выбранной картинки и удаляет кнопку*/
        $(this).before('<span>Обложка</span>');
        $(this).hide();

        /*Если обложка до этого была, то удаляем из под нее надпись обложка и добавляем кнопку*/
        if (previous_preview != ''){
            $(document).find('*[data-picture-id=' + previous_preview + ']').find('span').remove();
            $(document).find('*[data-picture-id=' + previous_preview + ']').find('.set-preview').show();
        }
    });
});