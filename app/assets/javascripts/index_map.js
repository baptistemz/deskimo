$(document).ready(function(){
  var win_height = $(window).height() - 55;
  $('#desktop-map').css("height", win_height);
  $(window).resize(function() {
    var win_height = $(window).height() - 55;
    $('#desktop-map').css("height", win_height);
  });
//   // $(window).scroll(function(){
//   //   var scroll = $(document).scrollTop()
//   //   var str = [(15+str), "px"].join("")
//   //   $('.map-outer').css('top', str );
//   // });
  $('.map-btn').click(function(){
    $('#mobile-map').toggleClass('out-window');;
    $('#map-icon').toggleClass('hidden');
    $('#list-icon').toggleClass('hidden');
  });
});
