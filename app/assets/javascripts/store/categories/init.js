
$(document).ready(function () {
    var mobile = false;
    if(document.documentElement.clientWidth < 801)
    {
        mobile = true;
        $('#filterrific_filter').appendTo('.row.filter .filter-right');
    }
    $(window).resize(function() {
        if((mobile) && (document.documentElement.clientWidth > 800)) {
            $('#filterrific_filter').insertAfter($('body > main > div.container > div > div.col.s12.filter'));
            mobile = false;
        }else{
            if((!mobile) && (document.documentElement.clientWidth < 801)){
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
                'min': [0, 1000],
                '5%': [1000, 2000],
                '10%': [2000, 3000],
                '15%': [3000, 4000],
                '20%': [4000, 5000],
                '25%': [5000, 6000],
                '30%': [6000, 7000],
                '35%': [7000, 8000],
                '40%': [8000, 9000],
                '45%': [9000, 10000],
                '50%': [10000, 15000],
                '55%': [15000, 20000],
                '60%': [20000, 30000],
                '65%': [30000, 40000],
                '70%': [40000, 50000],
                '75%': [50000, 60000],
                '80%': [60000, 70000],
                '85%': [70000, 80000],
                '90%': [80000, 90000],
                '95%': [90000, 100000],
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
















