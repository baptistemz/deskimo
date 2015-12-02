$('#booking_time_slot_type').on('change', function(event) {
  if ($(this).val() === 'heure(s)') {
    $('.time-select').removeClass('hidden')
  } else {
    $('.time-select').addClass('hidden')
  }
});

function timeRecap($param) {
  $param.on('change', function(event) {
    var endingHour = parseInt($('#booking_start_date_time_4i').val()) + parseInt($('#booking_time_slot_quantity').val())
    var endingMinutes = parseInt($('#booking_start_date_time_5i').val())
    if (endingMinutes === 0) {
      $('#time-recap').text(endingHour+'h')
    } else {
      $('#time-recap').text(endingHour+'h'+endingMinutes)
    }
  });
};


timeRecap($('#booking_start_date_time_4i'));
timeRecap($('#booking_start_date_time_5i'));
timeRecap($('#booking_time_slot_quantity'));

$('.plus-button').on('click', function(event) {
  var endingHour = parseInt($('#booking_start_date_time_4i').val()) + parseInt($('#booking_time_slot_quantity').val()) + 1
  var endingMinutes = parseInt($('#booking_start_date_time_5i').val())
  if (endingMinutes === 0) {
    $('#time-recap').text(endingHour+'h')
  } else {
    $('#time-recap').text(endingHour+'h'+endingMinutes)
  }
});

$('.minus-button').on('click', function(event) {
  var endingHour = parseInt($('#booking_start_date_time_4i').val()) + parseInt($('#booking_time_slot_quantity').val()) - 1
  var endingMinutes = parseInt($('#booking_start_date_time_5i').val())
  if (endingMinutes === 0) {
    $('#time-recap').text(endingHour+'h')
  } else {
    $('#time-recap').text(endingHour+'h'+endingMinutes)
  }
});


