$(document).ready(function(){
  $('#geoloc').click(function(){
    $.get("http://ipinfo.io", function(response) {
        console.log(response.loc);
    }, "jsonp");
  });
});
