/*!
 * Start Bootstrap - SB Admin 2 v3.3.7+1 (http://startbootstrap.com/template-overviews/sb-admin-2)
 * Copyright 2013-2016 Start Bootstrap
 * Licensed under MIT (https://github.com/BlackrockDigital/startbootstrap/blob/gh-pages/LICENSE)
 */

// Мои кастомные скрипты (ГОСПОДИ, КАКИЕ КАСТЫЛИ)
// $(function() {
// //     document.getElementById('weight-input').addEventListener('input', function(e){
// //         document.getElementById('price-input').value = (this.value * document.getElementById('price-per-gramm-input').value).toFixed(2);
// // });
//     document.getElementById('price-per-gramm-input').addEventListener('input', function(e){
//         document.getElementById('price-input').value = (this.value * document.getElementById('weight-input').value).toFixed(2);
// });
// });

//Пытался сделать очистку поля
/*
$(document).ready(function() {
    $(".bs-searchbox").addClass("input-group");
    $(".bs-searchbox").append('<span class="input-group-btn"><input class="btn btn-default" type="button"><i class="glyphicon glyphicon-remove-circle"></i></input></span>');
    var clearBtn = $(".searchbox-clear");
    clearBtn.on('click', (function(){
        $('.bs-searchbox input').val('');
    }));
});
*/

$(function () {

});

$(function() {
    //считает новую цену, в зависимости от скидки
    function new_price () {
        var percentage = $('input[type=radio][name="product[sale_size_id]"]:checked').parent().attr("data-value");
        var price = $('#price-input').val();
        var sale_price = (price - ( price * percentage / 100 )).toFixed(2);
        if (sale_price > 0) {
            $("#new-price-input").val (sale_price)
        }  else {
            $("#new-price-input").val('')
        }
    }

    // Считает старую цену
    function old_price() {
        $("#price-input").val( ($("#weight-input").val() * $("#price-per-gramm-input").val() ).toFixed(2));
        new_price();
    }
    old_price();

    // Подсчет цены по кнопке
    $(".calculate").click(function () {
        old_price();
    });

    $("#price-input").on("input",function(){
        new_price();
    });

    $("#weight-input").on('input', function () {
        old_price();
    });
    $("#price-per-gramm-input").on('input', function() {
        old_price();
    });


    $('input[name="product[sale_size_id]"]').click(function sale(){
        var percentage = $(this).parent().attr("data-value");
        var price = $('#price-input').val();
        var sale_price = (price - ( price * percentage / 100 )).toFixed(2);
        if (sale_price > 0) {
            $("#new-price-input").val (sale_price)
        }  else
        {
            $("#new-price-input").val('')
        }
    });
});
//
// $(document).ready(function() {
//     sale();
// });

$(function() {
    $('#side-menu').metisMenu();
});



$(document).ready(function() {
    $('#dataTables-example').DataTable({
        responsive: true,
        columnDefs: [
            { responsivePriority: 1, targets: 0 },
            { responsivePriority: 1, targets: 1 },
            { responsivePriority: 3, targets: -3 },
            { responsivePriority: 2, targets: -2 },
            { responsivePriority: 1, targets: -1 }
        ],
        "language": {
            "processing": "Подождите...",
            "search": "Поиск:",
            "lengthMenu": "Показать _MENU_ записей",
            "info": "Записи с _START_ до _END_ из _TOTAL_ записей",
            "infoEmpty": "Записи с 0 до 0 из 0 записей",
            "infoFiltered": "(отфильтровано из _MAX_ записей)",
            "infoPostFix": "",
            "loadingRecords": "Загрузка записей...",
            "zeroRecords": "Записи отсутствуют.",
            "emptyTable": "В таблице отсутствуют данные",
            "paginate": {
                "first": "Первая",
                "previous": "Предыдущая",
                "next": "Следующая",
                "last": "Последняя"
            },
            "aria": {
                "sortAscending": ": активировать для сортировки столбца по возрастанию",
                "sortDescending": ": активировать для сортировки столбца по убыванию"
            }
        }
    });
    $('#table').css("visibility", "visible");
});


//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size


$(window).bind("resize load", function() {
    var topOffset = 50;
    var width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
    if (width < 768) {
        $('div.navbar-collapse').addClass('collapse');
        topOffset = 100; // 2-row-menu
    } else {
        $('div.navbar-collapse').removeClass('collapse');
    }
    var height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
    height = height - topOffset;
    if (height < 1) height = 1;
    if (height > topOffset) {
        $("#page-wrapper").css("min-height", (height) + "px");
    }

});

$(function() {
    var url = window.location;
    // var element = $('ul.nav a').filter(function() {
    //     return this.href == url;
    // }).addClass('active').parent().parent().addClass('in').parent();
    var element = $('ul.nav a').filter(function() {
        return this.href == url;
    }).addClass('active').parent();

    while (true) {
        if (element.is('li')) {
            element = element.parent().addClass('in').parent();
        } else {
            break;
        }
    }
});


