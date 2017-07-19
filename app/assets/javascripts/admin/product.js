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
        addRemoveLinks: true
    });
});