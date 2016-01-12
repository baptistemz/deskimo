$('.time-slot-type').on('change', function(event) {

  if ($(this).val() === 'half_day') {
    $('.half-day-select').removeClass('hidden')
    $('.time-slot-quantity').val(1)
    $('.time-slot-quantity').addClass('hidden')
  } else {
    $('.half-day-select').addClass('hidden')
    $('.time-slot-quantity').removeClass('hidden')
  }
});

$(document).on( 'shown.bs.tab', 'a[data-toggle="tab"]', function () {
  $('.time-slot-type').val('day(s)')
  if($('.time-slot-quantity').is( ":hidden" )){
    $('.time-slot-quantity').removeClass('hidden')
  }
  if($('.half-day-select').is( ":visible" )){
    $('.half-day-select').addClass('hidden')
  }
});




