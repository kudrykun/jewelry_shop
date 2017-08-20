$(document).ready(function () {
    $(".shop-sizes").on("changed.bs.select", function(e, clickedIndex, newValue, oldValue) {
        var size_id = +$(this).find('option').eq(clickedIndex).val();
        var date = new Date();
        date = date.getTime();
        var shop_id = $(this).data('shop-id');
        /*Если форма на создание нвого товара, а не редактирование, то нужно взять рандомный Id*/
        /*if((/new/g).test($('form')[0].id))
            shop_id = date.getTime() + 1;
        else
            shop_id = $(this).data('shop-id');*/

        /*Ищем чекбокс в диве с нужными полями*/
        var delete_size = $('#shop_' + shop_id + '_size_' + size_id).find('input:checkbox');
        /*Если поставили галочку*/
        if(newValue && !oldValue && (typeof shop_id != "undefined")){
            /*Если есть чекбокс, то ставим ему false*/
            if(delete_size.length){
                delete_size.prop('checked',false);
            /*Иначе, добавляем новые поля*/
            }else {
                $('#shop_' + shop_id + '_sizes').find('.hidden-fields').append(
                    '<div id="shop_' + shop_id + '_size_' + size_id + '">' +
                    '<input type="hidden" value="' + shop_id + '" name="product[size_items_attributes][' + date + '][shop_id]" id="product_size_items_attributes_' + date + '_shop_id">' +
                    '<input type="hidden" value="' + size_id + '" name="product[size_items_attributes][' + date + '][size_id]" id="product_size_items_attributes_' + date + '_size_id">' +
                    '</div>'
                );
            }
        }
        /*Если убираем галочку*/
        if(!newValue && oldValue && (typeof shop_id != "undefined")){
            /*Если есть чекбокс, то ставим ему tru*/
            if(delete_size.length){
                delete_size.prop('checked',true);
            /*Иначе удаляем элементы*/
            }else {
                $('<div id="shop_' + shop_id + '_size_' + size_id + '">').remove();
            }
        }
    });
});

/*#TODO при использованиии класса shop sizes вместо id выстреливает два события change.Буду обрабатывать это циклом*/
/*#TODO при эти обстоятельствах shop_id получается undefined во второй раз выстреливая события*/