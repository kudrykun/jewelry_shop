/*!
 * Start Bootstrap - SB Admin 2 v3.3.7+1 (http://startbootstrap.com/template-overviews/sb-admin-2)
 * Copyright 2013-2016 Start Bootstrap
 * Licensed under MIT (https://github.com/BlackrockDigital/startbootstrap/blob/gh-pages/LICENSE)
 */

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size


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
        "search": "Поиск по всей таблице:",
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
    $('#table').css("visibility", "visible");
    $('i.fa-refresh').remove();
    $('.category_dataTable').dataTable( {
        "order": [[ 2, "asc" ]]
    });
});

$(document).ready(function() {

    $('#dataTables-example').DataTable( {
        initComplete: function () {
            this.api().columns([0,1,2,3]).every( function () {
                var column = this;
                var select = $('<select class="selectpicker" data-width="fit" title="..."><option value=""></option></select>')
                    .appendTo( $(column.footer()).empty() )
                    .on( 'change', function () {
                        var val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );

                        column
                            .search( val ? '^'+val+'$' : '', true, false )
                            .draw();
                    } );

                column.data().unique().sort().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                } );
            } );
        }
    } );
} );


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

$(function () {
    $('body').tooltip({selector: '[data-toggle="tooltip"]'});
});
