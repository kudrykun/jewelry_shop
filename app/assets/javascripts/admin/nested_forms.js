$(document).ready(function () {
    /*при нажатии на чекбокс или его подобие*/

    $(document).on('click', '.delete-insert', function () {
    // $('i.fa').click(function(){
        $(this).parent().parent().fadeOut(500, function() {   /*Предполагется, что исчезает весь контейнер со связанными полями*/
            if ($(this).parent().parent().hasClass('dynamically-added')) {
                /*Если этот контейнер был добавлен динамически, то подчищаем html*/
                $(this).parent().parent().remove();
            }else{
                /*Если он добавлен не динамически, то оставляем его, чтобы данные на удаление были переданы в контроллер*/
                // $(this).prop('checked',true);
                $(this).find('.destroy-incrustation').prop('checked',true);//
            }
        });

        });
/*
    $(document).on('change', '.destroy-incrustation', function () {
        $(this).parent().parent().fadeOut(500, function() {   /!*Предполагется, что исчезает весь контейнер со связанными полями*!/
            if ($(this).parent().parent().hasClass('dynamically-added')) {
                /!*Если этот контейнер был добавлен динамически, то подчищаем html*!/
                $(this).parent().parent().remove();
            }else{
                /!*Если он добавлен не динамически, то оставляем его, чтобы данные на удаление были переданы в контроллер*!/
                $(this).prop('checked',true);
            }
        });

    });*/
});
