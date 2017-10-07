
/*var priceSlider = document.getElementById('priceSlider-desktop');
$(document).ready(function () {
    noUiSlider.create(priceSlider, {
        start: [0, 100000],
        connect: true,
        step: 1000,
        range: {
            'min': [0, 500],
            '5%': [500, 1000],
            '10%': [1000, 2000],
            '15%': [2000, 3000],
            '20%': [3000, 4000],
            '30%': [4000, 5000],
            '40%': [5000, 6000],
            '50%': [6000, 7000],
            '60%': [7000, 8000],
            '65%': [8000, 9000],
            '70%': [9000, 10000],
            '75%': [10000, 15000],
            '80%': [15000, 20000],
            '85%': [25000, 50000],
            '90%': [50000, 80000],
            '95%': [80000, 100000],
            'max': [100000]
        }
    });*/


/*
    var inputNumber1 = document.getElementById('input-with-priceSlider-desktop0');
    var inputNumber2 = document.getElementById('input-with-priceSlider-desktop1');

    priceSlider.noUiSlider.on('update', function( values, handle ) {

        var value = values[handle];

        if ( handle ) {
            inputNumber2.value = Math.round(value);
        }
        else {
            inputNumber1.value = Math.round(value);
        }
    });
});

    inputNumber1.addEventListener('change', function(){
        html5Slider.noUiSlider.set([this.value, null]);
    });

    inputNumber2.addEventListener('change', function(){
        html5Slider.noUiSlider.set([null, this.value]);
    });
*/




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
            keypressSlider.noUiSlider.set([null, this.value]);
        });
        input1.addEventListener('change', function(){
            keypressSlider.noUiSlider.set([null, this.value]);
        });
    })();
});

