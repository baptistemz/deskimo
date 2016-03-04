$(document).ready(function(){
  if($("#desk-choice").length){
    kind = $("#desk-choice li.first-degree.active a").attr('id').slice(0,-4)
    if(typeof $(".tab-pane.active .nav li.second-degree.active a").attr('id') != 'undefined'){
      number = $(".tab-pane.active .nav li.second-degree.active a").attr('id').slice(4,-4)
    } else {
      number = 1
    }
    giveEndEstimation(kind, number)
  }



  $(document).on( 'shown.bs.tab', 'a.show-tab[data-toggle="tab"]', function (e) {
    kind = $("#desk-choice li.first-degree.active a").attr('id').slice(0,-4)
    if(typeof $(".tab-pane.active .nav li.second-degree.active a").attr('id') != 'undefined'){
      number = $(".tab-pane.active .nav li.second-degree.active a").attr('id').slice(4,-4)
    } else {
      number = 1
    }
    $("." + kind + "_" + number +'_booking #booking_time_slot_quantity.numeric').val(1)
    $("." + kind + "_" + number +'_booking #booking_time_slot_type').val('day(s)')
    $("." + kind + "_" + number +'_booking .time-slot-quantity.hidden').removeClass('hidden')
    $("." + kind + "_" + number + "_booking .end_prediction.hidden").removeClass('hidden')
    $("." + kind + "_" + number +'_booking .half-day-select:not(.hidden)').addClass('hidden')
    $(".predicted_end").empty()
    giveEndEstimation(kind, number)
  });
});


function giveEndEstimation(kind, number) {
  $(document).ready(predictEnd);
  $("." + kind + "_" + number + "_booking #booking_time_slot_type").on('change', predictEnd);
  $("." + kind + "_" + number + "_booking #booking_time_slot_quantity").on('change', predictEnd);
  $("." + kind + "_" + number + "_booking .plus-button").on('click', predictEnd);
  $("." + kind + "_" + number + "_booking .minus-button").on('click', predictEnd);
  $("." + kind + "_" + number + "_booking #booking_start_date").on('change', predictEnd);
  $('.minusmonth').click(predictEnd);
  $('.addmonth').click(predictEnd);

  function predictEnd() {
    if ($("." + kind + "_" + number + "_booking #booking_time_slot_type").val() === 'half_day') {
      $("." + kind + "_" + number + "_booking .end_prediction:not(.hidden)").addClass('hidden')
      $("." + kind + "_" + number +'_booking .half-day-select.hidden').removeClass('hidden')
      $("." + kind + "_" + number +'_booking #booking_time_slot_quantity.numeric').val(1)
      $("." + kind + "_" + number +'_booking .time-slot-quantity:not(.hidden)').addClass('hidden')
      endDay = $("." + kind + "_" + number + "_booking #booking_start_date").val()
    } else if($("." + kind + "_" + number + "_booking #booking_time_slot_type").val() == 'day(s)'){
      $("." + kind + "_" + number +'_booking .half-day-select:not(.hidden)').addClass('hidden')
      $("." + kind + "_" + number +'_booking .time-slot-quantity.hidden').removeClass('hidden')
      $("." + kind + "_" + number + "_booking .end_prediction.hidden").removeClass('hidden')
      var nextDays = $("." + kind + "_" + number + "_booking #booking_start_date > option").map(function() { return $(this).val(); });
      var firstDayIndex = $.inArray($("." + kind + "_" + number + "_booking #booking_start_date").val(), nextDays)
      var lastDayIndex = parseInt(firstDayIndex) + parseInt($("." + kind + "_" + number + "_booking #booking_time_slot_quantity").val()) - 1
      var endDay = nextDays.get(lastDayIndex)
    } else if($("." + kind + "_" + number + "_booking #booking_time_slot_type").val() == 'week(s)'){
      $("." + kind + "_" + number +'_booking .half-day-select:not(.hidden)').addClass('hidden')
      $("." + kind + "_" + number +'_booking .time-slot-quantity.hidden').removeClass('hidden')
      $("." + kind + "_" + number + "_booking .end_prediction.hidden").removeClass('hidden')
      var nextDays = $("." + kind + "_" + number + "_booking #booking_start_date > option").map(function() { return $(this).val(); });
      var firstDayParts = $("." + kind + "_" + number + "_booking #booking_start_date").val().split('/')
      var firstDayDate = new Date(firstDayParts[2], firstDayParts[1] - 1, firstDayParts[0])
      var fictiveLastDay = getDateString(new Date(firstDayParts[2], firstDayParts[1] - 1, (parseInt(firstDayParts[0]) + parseInt($("." + kind + "_" + number + "_booking #booking_time_slot_quantity").val()) * 7 - 1).toString()))
      var fictiveLastDayMinusOne = getDateString(new Date(firstDayParts[2], firstDayParts[1] - 1, (parseInt(firstDayParts[0]) + parseInt($("." + kind + "_" + number + "_booking #booking_time_slot_quantity").val()) * 7 - 2).toString()))
      var fictiveLastDayMinusTwo = getDateString(new Date(firstDayParts[2], firstDayParts[1] - 1, (parseInt(firstDayParts[0]) + parseInt($("." + kind + "_" + number + "_booking #booking_time_slot_quantity").val()) * 7 - 3).toString()))
      var fictiveLastDayMinusThree = getDateString(new Date(firstDayParts[2], firstDayParts[1] - 1, (parseInt(firstDayParts[0]) + parseInt($("." + kind + "_" + number + "_booking #booking_time_slot_quantity").val()) * 7 - 4).toString()))
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
      $("." + kind + "_" + number + "_booking .end_prediction").addClass('hidden')
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

    var booked_range = [$("." + kind + "_" + number + "_booking #booking_start_date").val(), endDay]
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
            if (i < selectedDate){
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
      }
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


