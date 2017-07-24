// disable auto discover
Dropzone.autoDiscover = false;
$(document).ready(function(){
    // grap our upload form by its id
    var picture_ids = [];
    $("#new_picture").dropzone({
        // restrict image size to a maximum 1MB
        maxFilesize: 1,
        // changed the passed param to one accepted by
        // our rails app
        paramName: "picture[image]",
        // show remove links on each image upload
        addRemoveLinks: true,

        success: function(file, response) {
            $(document).find('.entity-images-container').find('.row').first('.col-md-2').after("<div class=\"col-md-2 entity-image\" data-picture-id='" + response.id + "'> <img src=\" " + response.url + "\" class=\"img-responsive\"></div>");
            $(file.previewTemplate).find('.dz-remove').attr('id',response.id);
            $(file.previewTemplate).addClass('dz-success');
            picture_ids.push(response.id);
            $(document).find('#picture_ids_').val(picture_ids);
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
                   picture_ids = jQuery.grep(picture_ids, function(value) {
                       return value != id;
                   });
                   $(document).find('#picture_ids_').val(picture_ids);
               }
            });
        }
    });
});