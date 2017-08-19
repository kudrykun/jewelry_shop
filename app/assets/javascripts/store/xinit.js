function initRadioSizes(container) {
  $(container).on("change", '.btn_sizes-group input[type="radio"]', function(event) {
    $(this).parents(".btn_sizes-group").find("label").removeClass('active');
    $(this).parent().addClass('active');
  })
}

$(function() {
      $('#buy-in-one-click').on('click', function(event) {
        event.preventDefault()
        var $link = $(event.currentTarget);
        var $input = $link.siblings('input');
        if ($link.prop('disabled')) {
          return;
        }
        $link.prop('disabled', true);
        phone = $("#phone").val()
        if (phone.replace(/[^\d]/g, '').length != 11) {
          Materialize.toast('Введите телефон.', 4000, 'red');
          $link.prop('disabled', false);
          return;
        }
        $.get("/catalogue/makecall/", data={
          name: phone,
          tel: phone,
          email: phone,
          comment: 'Здравствуйте, меня интересует изделие, арт. 94041',
          art: "94041",
          typeax: "1",
        }).success(function(data) {
          $input.prop('disabled', true);
          Materialize.toast('Заявка отправлена, в ближайшее время с Вами свяжуться', 4000)
        }).error(function() {
          Materialize.toast('Произошла ошибка, попробуйте еще раз.', 4000, 'red')
          $link.prop('disabled', false);
        });
      });

      initRadioSizes(document.body);
    });


function buildPriceRangeFilter(from, to) {
  var range = [
    [5, 5000],
    [10, 10000],
    [15, 15000],
    [20, 20000],
    [30, 30000],
    [40, 40000],
    [50, 50000],
    [60, 60000],
    [65, 70000],
    [70, 80000],
    [75, 90000],
    [80, 100000],
    [85, 250000],
    [90, 500000],
    [95, 1000000],
  ];
  var result = {'min': 0};
  $.each(range, function(i, val) {
    result['' + val[0] + '%'] = val[1];
  });
  result['max'] = 9000000;
  for (var i=0; i<range.length; i++) {
    var percent = range[i][0];
    var price = range[i][1];
    if (price === from) { break; }
    if (price > from) {
      result['' + (percent - 2) + '%'] = from;
      break;
    }
  }
  for (var i=0; i<range.length; i++) {
    var percent = range[i][0];
    var price = range[i][1];
    if (price === to) { break; }
    if (price > to) {
      var newPercent = '' + (percent - 2) + '%';
      if (result[newPercent]) {
        newPercent = '' + (percent - 1) + '%';
      }
      result[newPercent] = to;
      break;
    }
  }
  return result;
}

(function($){

  $(document).on('materialize', function () {
    $('select').material_select();
  });

  $(function(){
    $('.button-collapse').sideNav({
      menuWidth: 600,
      edge: 'right',
      closeOnClick: true,
      draggable: true
    });
    $('ul.tabs').tabs();
    $('.collapsible').collapsible();
    $('select').material_select();
    $('.materialboxed').materialbox();
    $('.modal').modal();
    $('select').material_select();
    $('.parallax').parallax();

  });


  
  // Email subscription (footer)
  $('form#email-subscribe').on('submit', function(event) {
    event.preventDefault();
    email = $('#subscription-email').val();
    directCrm('identify', {
      operation: 'EmailSubscribeMain',
      identificator: {
        provider: 'email',
        identity: email
      },
      success: function () {
        // Сообщаем потребителю, что он успешно подписан
        Materialize.toast('Вы подписаны на новостную рассылку', 3000);
      },
      error: function () {
        // Сообщаем потребителю, что что-то пошло не так
        Materialize.toast('Произошла ошибка. Повторите позднее', 3000);
      }
    });
  });

})(jQuery);
