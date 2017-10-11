
$(document).ready(function () {
    var mobile = false;
    if(document.documentElement.clientWidth < 801)
    {
        mobile = true;
        $('#filterrific_filter').appendTo('.row.filter .filter-right');
    }
    $(window).resize(function() {
        if((mobile) && (document.documentElement.clientWidth > 785)) {
            $('#filterrific_filter').prependTo($('.row.filterrific'));
            mobile = false;
        }else{
            if((!mobile) && (document.documentElement.clientWidth < 786)){
                $('#filterrific_filter').appendTo('.row.filter .filter-right');
                mobile = true;
            }
        }
    });



});

$(document).ready(function () {
    (function() {
        var keypressSlider = document.getElementById('priceSlider-desktop');
        var input0 = document.getElementById('input-with-priceSlider-desktop0');
        var input1 = document.getElementById('input-with-priceSlider-desktop1');
        var inputs = [input0, input1];

        noUiSlider.create(keypressSlider, {
            start: [!input0.value ? 0 : input0.value, !input1.value ? 1000000 : input1.value ],
            connect: true,
            step: 1000,
            range: {
                'min': [0],
                'max': [100000]
            }
        });

        keypressSlider.noUiSlider.on('update', function( values, handle ) {
            inputs[handle].value = Math.round(values[handle]);
        });

        keypressSlider.noUiSlider.on('end', function( values, handle ) {
            if(handle == 0){
                $(input0).trigger("change");
            }
            else {
                $(input1).trigger("change");
            }
        });

        input0.addEventListener('change', function(){
            keypressSlider.noUiSlider.set([this.value, null]);
        });
        input1.addEventListener('change', function(){
            keypressSlider.noUiSlider.set([null, this.value]);
        });
    })();
});
















