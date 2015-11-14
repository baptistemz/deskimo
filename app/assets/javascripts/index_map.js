$(document).ready(function(){
  var win_height = $(window).height() - 55;
  var win_width = $(window).width();
  if(win_width > 767) {
    $('#map').css("height", win_height);
    $('.map-outer').css('top', '15px');
  }else{
    $('#map').css("height", win_height - 60);
    $('.map-outer').css('top', '80px');
  }
  $(window).resize(function() {
    var win_height = $(window).height() - 55;
    var win_width = $(window).width();
    if(win_width > 767) {
      $('#map').css("height", win_height);
      $('.map-outer').css('top', '15px');
    }else{
      $('#map').css("height", win_height - 60);
      $('.map-outer').css('top', '80px');
    }
  });
  // $(window).scroll(function(){
  //   var scroll = $(document).scrollTop()
  //   var str = [(15+str), "px"].join("")
  //   $('.map-outer').css('top', str );
  // });
  $('.map-btn').click(function(){
    $('.map-outer').toggleClass('hidden-xs');
    $('.col-sm-5').toggleClass('hidden-xs');
    $('#map-icon').toggleClass('hidden');
    $('#list-icon').toggleClass('hidden');
  });
});
