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


function renderCal(themonth){
$('.calendar li').remove();
$('.calendar ul').append('<li>L</li><li>M</li><li>M</li><li>J</li><li>V</li><li>S</li><li>D</li>');


  var d = new Date();
  var currentMonth = d.getMonth()+themonth; // get this month
  if(currentMonth > 12){
    var currentMonth = currentMonth - 12
  }

  var days = numDays(currentMonth,d.getYear()), // get number of days in the month
    fDay = firstDay(currentMonth,d.getYear())-1, // find what day of the week the 1st lands on
    months = ['Janvier','Fevrier','Mars','Avril','Mai','Juin','Juillet','Aout','Septembre','Octobre','Novembre','Decembre']; // month names
$('.calendar p.monthname').text(months[currentMonth-1]); // add month name to calendar



for (var i=0;i<fDay-1;i++) { // place the first day of the month in the correct position
  $('<li>&nbsp;</li>').appendTo('.calendar ul');
}






for (var i = 1;i<=days;i++) {
  $('<li>'+i+'</li>').appendTo('.calendar ul');
};


var availableDaysArray = new Array();
$("#booking_start_date option").each(function()
  {
    availableDay = parseInt($(this).val().substring(8, 10))
    availableDaysArray.push(availableDay)
  }
);

lastDayOfMonth = Math.max.apply(Math,availableDaysArray)
firstDayOfMonth = Math.min.apply(Math,availableDaysArray)

firstDayMonth = parseInt($("#booking_start_date option:nth(0)").val().substring(5, 7))
if ($('.calendar p.monthname').text() == months[firstDayMonth - 1]){
  $("li:contains("+availableDaysArray[0].toString()+")").addClass('available')
  for (var i = availableDaysArray[0]; i <= lastDayOfMonth; i++){
    if (availableDaysArray.includes(i)){
      $("li:contains("+i.toString()+")").addClass('available')
    }
  }

}else if ($('.calendar p.monthname').text() == months[firstDayMonth]){
  $("li:contains("+firstDayOfMonth.toString()+")").addClass('available')
  for (var i = firstDayOfMonth; i <= availableDaysArray[availableDaysArray.length - 1]; i++){
    if (availableDaysArray.includes(i)){
      $("li:contains("+i.toString()+")").addClass('available')
    }
  }
}else if ($('.calendar p.monthname').text() == months[0]){
  for (var i = firstDayOfMonth; i <= availableDaysArray[availableDaysArray.length - 1]; i++){
    if (availableDaysArray.includes(i)){
      $("li:contains("+i.toString()+")").addClass('available')
    }
  }
}

// if ($('.calendar p.monthname').text() == months[0]){
//   for (var i = firstDayOfMonth; i <= availableDaysArray[-1]; i++){
//     if (availableDaysArray.contains(i)){
//       $("li:contains("+i.toString()+")").addClass('available')
//     }
//   }
// }

}

function firstDay(month,year) {
  return new Date(year,month,1).getDay();
}

function numDays(month,year) {
  return new Date(year,month,0).getDate();
}

var clicker = 0;
var min = 0;
var max = 0;

$('.calendar li.available').click(function(){ // toggle selected dates
  if(clicker==0){
    clicker=1;
    $(this).toggleClass('selected');
    min = $(this).text();
  } else {
    clicker=0;
    $(this).addClass('red');
    $('.calendar li.red').each(function(){
      max = $(this).text();
    });
    for(i=parseInt(min);i<parseInt(max);i++){
      $('.calendar li:nth-of-type('+(i+7+fDay-1)+')').addClass('red');
    }
  }
});

