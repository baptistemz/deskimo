$(document).ready(function(){
  kind = $("#desk-choice li.active a").attr('id').slice(0,-4)
  giveEndEstimation(kind)

  $(document).on( 'shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
    kind = e.currentTarget.id.slice(0,-4)
    $("." + kind +'_booking #booking_time_slot_quantity.numeric').val(1)
    $("." + kind +'_booking #booking_time_slot_type').val('day(s)')

    // if($('.time-slot-quantity').is( ":hidden" )){
    //   $(this).removeClass('hidden')
    // }
    $("." + kind +'_booking .time-slot-quantity.hidden').removeClass('hidden')

    // if($('.end_prediction').is( ":hidden" )){
    //   $(this).removeClass('hidden')
    // }
    $("." + kind + "_booking .end_prediction.hidden").removeClass('hidden')

    // if($('.half-day-select').is( ":visible" )){
    //   $(this).addClass('hidden')
    // }
    $("." + kind +'_booking .half-day-select:not(.hidden)').addClass('hidden')

   $(".predicted_end").empty()
   giveEndEstimation(kind)
  });
});


function giveEndEstimation(kind) {
  $(document).ready(predictEnd);
  $("." + kind + "_booking #booking_time_slot_type").on('change', predictEnd);
  $("." + kind + "_booking #booking_time_slot_quantity").on('change', predictEnd);
  $("." + kind + "_booking .plus-button").on('click', predictEnd);
  $("." + kind + "_booking .minus-button").on('click', predictEnd);
  $("." + kind + "_booking #booking_start_date").on('change', predictEnd);
  $('.minusmonth').click(predictEnd);
  $('.addmonth').click(predictEnd);

  function predictEnd() {
    if ($("." + kind + "_booking #booking_time_slot_type").val() === 'half_day') {
      $("." + kind + "_booking .end_prediction:not(.hidden)").addClass('hidden')
      $("." + kind +'_booking .half-day-select.hidden').removeClass('hidden')
      $("." + kind +'_booking #booking_time_slot_quantity.numeric').val(1)
      $("." + kind +'_booking .time-slot-quantity:not(.hidden)').addClass('hidden')
      endDay = $("." + kind + "_booking #booking_start_date").val()
    } else if($("." + kind + "_booking #booking_time_slot_type").val() == 'day(s)'){
      $("." + kind +'_booking .half-day-select:not(.hidden)').addClass('hidden')
      $("." + kind +'_booking .time-slot-quantity.hidden').removeClass('hidden')
      $("." + kind + "_booking .end_prediction.hidden").removeClass('hidden')
      var nextDays = $("." + kind + "_booking #booking_start_date > option").map(function() { return $(this).val(); });
      var firstDayIndex = $.inArray($("." + kind + "_booking #booking_start_date").val(), nextDays)
      var lastDayIndex = parseInt(firstDayIndex) + parseInt($("." + kind + "_booking #booking_time_slot_quantity").val()) - 1
      var endDay = nextDays.get(lastDayIndex)
    } else if($("." + kind + "_booking #booking_time_slot_type").val() == 'week(s)'){
      $("." + kind +'_booking .half-day-select:not(.hidden)').addClass('hidden')
      $("." + kind +'_booking .time-slot-quantity.hidden').removeClass('hidden')
      $("." + kind + "_booking .end_prediction.hidden").removeClass('hidden')
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

    var booked_range = [$("." + kind + "_booking #booking_start_date").val(), endDay]
    selectBookedDays(booked_range)
    function selectBookedDays(dates_range) {
      var selectedDate = parseInt(dates_range[0].substring(0, 2))
      var endDate = parseInt(dates_range[1].substring(0, 2))
      var selectedDayMonth = parseInt(dates_range[0].substring(4, 6));
      var endDayMonth = parseInt(dates_range[1].substring(4, 6));
      var today = new Date();
      var currentMonth = today.getMonth()+1;
      var lastDayOfCurrentMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0).getDate()
      var calendarMonth = $('.calendar p.monthname').text()
      if (monthsEqual(calendarMonth, selectedDayMonth)){
        if (endDayMonth === selectedDayMonth){
          for (var i = 1; i <= lastDayOfCurrentMonth; i++){
            if (i <= endDate  && i >= selectedDate){
              $("li.available:not(.selected):contains("+('0'+i).slice(-2)+")").addClass('selected')
            } else {
              $("li.available.selected:contains("+('0'+i).slice(-2)+")").removeClass('selected')
            }
          }
        } else {
          for (var i = 1; i <= lastDayOfCurrentMonth; i++){
            if (i >= selectedDate){
              $("li.available:not(.selected):contains("+('0'+i).slice(-2)+")").addClass('selected')
            }
            if (i <= selectedDate){
              $("li.available.selected:contains("+('0'+i).slice(-2)+")").removeClass('selected')
            }
          }
        }
      } else if (monthsEqual(calendarMonth, selectedDayMonth + 1)){
        if (endDayMonth === selectedDayMonth){
          for (var i = 1; i <= lastDayOfCurrentMonth; i++){
            if (i <= endDate  && i >= selectedDate){
              $("li.available:not(.selected):contains("+('0'+i).slice(-2)+")").addClass('selected')
            } else {
              $("li.available.selected:contains("+('0'+i).slice(-2)+")").removeClass('selected')
            }
          }
        } else {
          for (var i = 1; i <= 31; i++){
            if (i <= endDate){
              $("li.available:not(.selected):contains("+('0'+i).slice(-2)+")").addClass('selected')
            }
            if (i > endDate){
              $("li.available.selected:contains("+('0'+i).slice(-2)+")").removeClass('selected')
            }
          }
        }
        // else {
        //   for (var i = 1; i <= lastDayOfCurrentMonth; i++){
        //     if (i >= selectedDate){
        //       $("li.available:not(.selected):contains("+('0'+i).slice(-2)+")").addClass('selected')
        //     } else {
        //       $("li.available.selected:contains("+('0'+i).slice(-2)+")").removeClass('selected')
        //     }
        //   }
        // }
      }
      // else if (monthsEqual(calendarMonth, selectedDayMonth + 1)){
      //   for (var i = 1; i <= availableDaysArray[availableDaysArray.length - 1]; i++){
      //     $("li:contains("+('0'+i).slice(-2)+")").addClass('unavailable')
      //   }
      // }else if ($('.calendar p.monthname').text().includes(months[0]) && (firstDayMonth === '01' || firstDayMonth === '12') ){
      //   for (var i = 1; i <= availableDaysArray[availableDaysArray.length - 1]; i++){
      //     $("li:contains("+('0'+i).slice(-2)+")").addClass('unavailable')
      //   }
      // }
    }
    function dayNumber(dateString){
      parseInt(dateString.substring(0, 2))
    }
    function monthsEqual(string, integer){
      months = ['Janvier','Fevrier','Mars','Avril','Mai','Juin','Juillet','Aout','Septembre','Octobre','Novembre','Decembre'];
      if (string.includes(months[integer-1])) {
        return true
      } else {
        return false
      }
    }
  }
}


