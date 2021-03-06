if($("#desk-choice").length > 0){
  $(document).ready(function(){
    kind = $("#desk-choice li.first-degree.active a").attr('id').slice(0,-4)
    if(typeof $(".tab-pane.active .nav li.second-degree.active a").attr('id') != 'undefined'){
      number = $(".tab-pane.active .nav li.second-degree.active a").attr('id').slice(4,-4)
    } else {
      number = 1
    }
    loadCalendar(kind, number)
  });

  $(document).on( 'shown.bs.tab', 'a.show-tab[data-toggle="tab"]', function (e) {
   // kind = e.currentTarget.id.slice(0,-4)
    kind = $("#desk-choice li.first-degree.active a").attr('id').slice(0,-4)
    if(typeof $(".tab-pane.active .nav li.second-degree.active a").attr('id') != 'undefined'){
      number = $(".tab-pane.active .nav li.second-degree.active a").attr('id').slice(4,-4)
    } else {
      number = 1
    }
    loadCalendar(kind, number)
  });
}

function loadCalendar(kind, number){
  if ($("." + kind + '_' + number + "_booking #booking_start_date").length ) {


    function firstDay(month,year) {
      return new Date(year + 1, month - 1,1).getDay();
    }

    function numDays(month,year) {
      return new Date(year,month,0).getDate();
    }

    function renderCal(themonth){
    $('.calendar li').remove();
    $('.calendar ul').append('<li>L</li><li>M</li><li>M</li><li>J</li><li>V</li><li>S</li><li>D</li>');


      var d = new Date();
      var currentMonth = d.getMonth()+themonth; // get this month
      if(currentMonth > 12){
        var currentMonth = currentMonth - 12;
        d.setYear(d.getFullYear() + 1)
      } else if(currentMonth < 1){
        var currentMonth = currentMonth + 12;
        d.setYear(d.getFullYear() - 1)
      }
      lastDayOfCurrentMonth = new Date(d.getFullYear(), d.getMonth() + 1, 0).getDate()

      var days = numDays(currentMonth,d.getFullYear()), // get number of days in the month
        months = ['Janvier','Fevrier','Mars','Avril','Mai','Juin','Juillet','Aout','Septembre','Octobre','Novembre','Decembre']; // month names
    if( firstDay(currentMonth,d.getFullYear())-1 < 1){
      var fDay = firstDay(currentMonth,d.getFullYear())+6 // find what day of the week the 1st lands on
    }else{
      var fDay = firstDay(currentMonth,d.getFullYear())-1 // find what day of the week the 1st lands on
    }
    $('.calendar p.monthname').text(months[currentMonth-1]); // add month name to calendar
    for (var i=0;i<fDay - 1;i++) { // place the first day of the month in the correct position
      $('<li>&nbsp;</li>').appendTo('.calendar ul');
    }

    for (var i = 1;i<=days;i++) {
      $('<li>'+('0'+i).slice(-2)+'</li>').appendTo('.calendar ul');
    };


    var availableDaysArray = new Array();
    $("."+kind + '_' + number +"_booking #booking_start_date option").each(function()
      {
        if (parseInt($(this).val().substring(3, 5)) === currentMonth){
          availableDay = parseInt($(this).val().substring(0, 2))
          availableDaysArray.push(('0'+availableDay).slice(-2))
        }
      }
    );
// .indexOf("stage1") > -1
    lastAvailableDayOfMonth = Math.max.apply(Math,availableDaysArray)
    firstAvailableDayOfNextMonth = Math.min.apply(Math,availableDaysArray)
    firstDayMonth = parseInt($("."+kind + '_' + number +"_booking #booking_start_date option:nth(0)").val().substring(4, 6))
    if ($('.calendar p.monthname').text().indexOf(months[firstDayMonth - 1]) > -1){
      for (var i = availableDaysArray[0]; i <= lastDayOfCurrentMonth; i++){
        $("li:contains("+('0'+i).slice(-2)+")").addClass('unavailable')
      }
      $("li:contains("+('0'+ availableDaysArray[0].toString()).slice(-2)+")").addClass('available')
      if (availableDaysArray[1] > availableDaysArray[0]) {
        for (var i = availableDaysArray[1]; i <= lastAvailableDayOfMonth; i++){
          if (availableDaysArray.indexOf(('0'+i).slice(-2))> -1){
            $("li:contains("+('0'+i.toString()).slice(-2)+")").addClass('available')
          }
        }
      }
    }else if ($('.calendar p.monthname').text().indexOf(months[firstDayMonth])> -1){
      for (var i = 1; i <= availableDaysArray[availableDaysArray.length - 1]; i++){
        $("li:contains("+('0'+i.toString()).slice(-2)+")").addClass('unavailable')
      }
      $("li:contains("+('0'+firstAvailableDayOfNextMonth.toString()).slice(-2)+")").addClass('available')
      for (var i = firstAvailableDayOfNextMonth; i <= availableDaysArray[availableDaysArray.length - 1]; i++){
        if (availableDaysArray.indexOf(('0'+i).slice(-2))> -1){
          $("li:contains("+('0'+i.toString()).slice(-2)+")").addClass('available')
        }
      }
    }else if ($('.calendar p.monthname').text().indexOf(months[0])> -1 && (firstDayMonth === '01' || firstDayMonth === '12') ){
      for (var i = 1; i <= availableDaysArray[availableDaysArray.length - 1]; i++){
        $("li:contains("+('0'+i.toString()).slice(-2)+")").addClass('unavailable')
      }
      for (var i = firstAvailableDayOfNextMonth; i <= availableDaysArray[availableDaysArray.length - 1]; i++){
        if (availableDaysArray.indexOf(('0'+i).slice(-2))> -1){
          $("li:contains("+('0'+i.toString()).slice(-2)+")").addClass('available')
        }
      }
    }

    }
    if (typeof themonth === 'undefined'){
      var themonth = 1;
      renderCal(themonth);
    };
    $('.minusmonth').click(function(){
        themonth += -1;
        renderCal(themonth);
    });


    $('.addmonth').click(function(){
        themonth += 1;
        renderCal(themonth);

    });


    var clicker = 0;
    var min = 0;
    var max = 0;
  };
};
