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
            $(document).find('.entity-images-container').find('.row').find('.col-md-2:first').after("<div class=\"col-md-2 entity-image\" data-picture-id='" + response.id + "'> <img src=\" " + response.url + "\" class=\"img-responsive\"></div>");
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
});