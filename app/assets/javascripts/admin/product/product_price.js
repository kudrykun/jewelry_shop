
    $(function () {
        if ($('input[type=radio][name="product[sale_size_id]"]:checked').parent().attr("data-value") != null)
            if($('#price-input').val() != "")
                $("#new-price-input").removeAttr("readonly");

    });

    // делает поле новой цены недоступным, если поле цены пустое
    $("#price-input").on('keyup',function(){
        if($('#price-input').val() == "") {
            $("#new-price-input").val('');
            $("#new-price-input").prop("readonly", "readonly");
        }
    });

    // Считает новую цену
    function calc_new_price() {
        var percentage = $('input[type=radio][name="product[sale_size_id]"]:checked').parent().attr("data-value");
        if  (percentage != null) /*& ($("#price-input").val() != '' ) )*/ {
            if($('#price-input').val() != ""){
                $("#new-price-input").removeAttr("readonly");
                var price = $("#price-input").val();
                if (price != ''){
                    $("#new-price-input").val ((price - ( price * percentage / 100 )).toFixed(2));
                }
                else {
                    $("#new-price-input").val('');
                }
            }
        }
        else {
            $("#new-price-input").val('');
            $("#new-price-input").prop("readonly", "readonly");
        }
    }

    // Считает старую цену
    function old_price() {
        $("#price-input").val( ($("#weight-input").val() * $("#price-per-gramm-input").val() ).toFixed(2));
        calc_new_price();
    }

    $('input[name="product[sale_size_id]"]').click(function sale(){
        calc_new_price();
    });

    // раскоментить если надо сделать расчет сразу после загрузки страницы
    // old_price();

    // Подсчет цены по кнопке
    $(".calculate").click(function () {
        old_price();
    });

    $("#weight-input").on('input', function () {
        old_price();
    });

    $("#price-per-gramm-input").on('input', function() {
        old_price();
    });

    $("#price-input").on("input",function(){
        calc_new_price()
    });
    $("#new-price-input").on("input",function(){
        var percentage = $('input[type=radio][name="product[sale_size_id]"]:checked').parent().attr("data-value");
        var new_price = $("#new-price-input").val();
        $("#price-input").val (( new_price * 100 / (100 - percentage) ).toFixed(2));
    });
