/*!
 * Start Bootstrap - SB Admin 2 v3.3.7+1 (http://startbootstrap.com/template-overviews/sb-admin-2)
 * Copyright 2013-2016 Start Bootstrap
 * Licensed under MIT (https://github.com/BlackrockDigital/startbootstrap/blob/gh-pages/LICENSE)
 */

$(function() {
    $('#side-menu').metisMenu();
});

$(function () {
    $('body').tooltip({selector: '[data-toggle="tooltip"]'});
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
        $("#page-wrapper").css("min-height", (height+1) + "px");
    }

});

$(function() {
    var url = window.location;
    // console.log(url);
    // var element = $('ul.nav a').filter(function() {
    //     return this.href == url;
    // }).addClass('active').parent().parent().addClass('in').parent();
    var element = $('ul.nav a').filter(function() {
        // alert(url);
        // alert(this.href);
        // return (("url").indexOf("this.href")+1) ;
        // console.log(url.pathname);
        // console.log(this.href);
        // console.log(!!this.href.match(new RegExp(url.pathname, 'g')));
        //  console.log(this.href.match( new RegExp (url.href, \/admin\/.*\/));
        //  return (this.href.match( new RegExp( ) ));
        var link = url.href.match(/^(.*?)admin\/([^/]*)/);
        console.log(link[0]);
        return this.href == link[0];
        // return (this.href.indexOf(url) !== -1);
    }).addClass('active').parent();

    while (true) {
        if (element.is('li')) {
            element = element.parent().addClass('in').parent();
        } else {
            break;
        }
    }
});

$(function() {
    if ($('#notice').text()) {
        $('#notice').animate({top: 10}, 500);
        setTimeout(function(){
            $('#notice').animate({top: -60}, 500);
        }, 3000);
        $('#notice').click(function () {
            $('#notice').animate({top: -60}, 500);
        })
    }
});

$.extend( $.fn.dataTable.defaults, {
    responsive: true,
    order: [],
    columnDefs: [
        { responsivePriority: 1, targets: 0 },
        { responsivePriority: 1, targets: 1 },
        { responsivePriority: 4, targets: -4 },
        { responsivePriority: 3, targets: -3 },
        { responsivePriority: 2, targets: -2 },
        { responsivePriority: 1, targets: -1 }
    ],
    language: {
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
} );

$(document).ready(function() {
    $('#dataTables-example').DataTable({
    });
    $('#table').css("visibility", "visible");
    $('i.fa-refresh').remove();
    $('.category_dataTable').dataTable( {
        "order": [[ 2, "asc" ]]
    });
});



