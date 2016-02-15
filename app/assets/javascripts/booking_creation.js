if($("#desk-choice").length > 0){
  $('.time-slot-type').on('change', function(event) {

    if ($(this).val() === 'half_day') {
      $('.end_prediction').addClass('hidden')
      $('.half-day-select').removeClass('hidden')
      $('.time-slot-quantity').val(1)
      $('.time-slot-quantity').addClass('hidden')
    } else {
      $('.half-day-select').addClass('hidden')
      $('.time-slot-quantity').removeClass('hidden')
    }
  });

  $(document).on( 'shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
    $('.time-slot-type').val('day(s)')
    if($('.time-slot-quantity').is( ":hidden" )){
      $(this).removeClass('hidden')
    }
    if($('.end_prediction').is( ":hidden" )){
      $(this).removeClass('hidden')
    }
    if($('.half-day-select').is( ":visible" )){
      $(this).addClass('hidden')
    }
   kind = e.currentTarget.id.slice(0,-4)
   $(".predicted_end").empty()
   giveEndEstimation(kind)
  });

// $(document).on( 'shown.bs.tab', 'a[data-toggle="tab"]', clearEnd)
  $(document).ready(function(){
    kind = $("#desk-choice li.active a").attr('id').slice(0,-4)
    giveEndEstimation(kind)

  });
}


function giveEndEstimation(kind) {
  $("." + kind + "_booking #booking_time_slot_type").on('change', predictEnd )
  $("." + kind + "_booking #booking_time_slot_quantity").on('change', predictEnd )
  $("." + kind + "_booking .plus-button").on('click', predictEnd )
  $("." + kind + "_booking .minus-button").on('click', predictEnd )
  $("." + kind + "_booking #booking_start_date").on('change', predictEnd )

  function predictEnd() {
    if($("." + kind + "_booking #booking_time_slot_type").val() == 'day(s)'){
      if ($("." + kind + "_booking .end_prediction").hasClass('hidden')){
        $("." + kind + "_booking .end_prediction").removeClass('hidden')
      }
      var nextDays = $("." + kind + "_booking #booking_start_date > option").map(function() { return $(this).val(); });
      var firstDayIndex = $.inArray($("." + kind + "_booking #booking_start_date").val(), nextDays)
      var lastDayIndex = parseInt(firstDayIndex) + parseInt($("." + kind + "_booking #booking_time_slot_quantity").val()) - 1
      var endDay = nextDays.get(lastDayIndex)
    } else if($("." + kind + "_booking #booking_time_slot_type").val() == 'week(s)'){
      if ($("." + kind + "_booking .end_prediction").hasClass('hidden')){
        $("." + kind + "_booking .end_prediction").removeClass('hidden')
      }
      var nextDays = $("." + kind + "_booking #booking_start_date > option").map(function() { return $(this).val(); });
      var firstDayParts = $("." + kind + "_booking #booking_start_date").val().split('/')
      var firstDayDate = new Date(firstDayParts[2], firstDayParts[1] - 1, firstDayParts[0])
      var fictiveLastDay = getDateString(new Date(firstDayParts[2], firstDayParts[1] - 1, (parseInt(firstDayParts[0]) + parseInt($("." + kind + "_booking #booking_time_slot_quantity").val()) * 7 - 1).toString()))
      var fictiveLastDayMinusOne = getDateString(new Date(firstDayParts[2], firstDayParts[1] - 1, (parseInt(firstDayParts[0]) + parseInt($("." + kind + "_booking #booking_time_slot_quantity").val()) * 7 - 2).toString()))
      var fictiveLastDayMinusTwo = getDateString(new Date(firstDayParts[2], firstDayParts[1] - 1, (parseInt(firstDayParts[0]) + parseInt($("." + kind + "_booking #booking_time_slot_quantity").val()) * 7 - 3).toString()))
      var fictiveLastDayMinusThree = getDateString(new Date(firstDayParts[2], firstDayParts[1] - 1, (parseInt(firstDayParts[0]) + parseInt($("." + kind + "_booking #booking_time_slot_quantity").val()) * 7 - 4).toString()))
      if ($.inArray(fictiveLastDay, nextDays) != -1){
        endDay = fictiveLastDay
      } else if ($.inArray(fictiveLastDayMinusOne, nextDays) != -1){
        endDay = fictiveLastDayMinusOne
      } else if ($.inArray(fictiveLastDayMinusTwo, nextDays) != -1){
        endDay = fictiveLastDayMinusTwo
      } else if ($.inArray(fictiveLastDayMinusThree, nextDays) != -1){
        endDay = fictiveLastDayMinusThree
      } else {
        console.log(fictiveLastDay)
        endDay = "Week(s) booking impossible"
      }
    } else {
      $("." + kind + "_booking .end_prediction").addClass('hidden')
    }

    function getDateString(date) {
      var year = date.getFullYear();
      var month = '' + (date.getMonth() + 1);
      var day = '' + date.getDate();
      if (month.length < 2) month = '0' + month;
      if (day.length < 2) day = '0' + day;
      return day + '/' + month + '/' + year
    }
  $(".predicted_end").text(endDay)
  console.log(endDay)
  }
}


