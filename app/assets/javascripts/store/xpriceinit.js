$(document).ready(function () {
    (function() {
        var keypressSlider = document.getElementById('priceSlider-desktop');
        var input0 = document.getElementById('input-with-priceSlider-desktop0');
        var input1 = document.getElementById('input-with-priceSlider-desktop1');
        var inputs = [input0, input1];
        var start_from = parseInt("", 10) || 0;
        var start_to = parseInt("", 10) || 9000000;
        if (start_from > start_to) {
            start_from = 0;
            start_to = 9000000
        }

        noUiSlider.create(keypressSlider, {
            start: [start_from, start_to],
            connect: true,
            snap: true,
            range: buildPriceRangeFilter(start_from, start_to),
            format: {
                to: function ( value ) {
                    return value + '';
                },
                from: function ( value ) {
                    return value.replace('', '');
                }
            }
        });

        keypressSlider.noUiSlider.on('update', function( values, handle ) {
            inputs[handle].value = values[handle];
        });
    })()});