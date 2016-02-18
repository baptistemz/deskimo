$(document).ready(function(){

  $('.file').on('change', function(event) {
    if ($('#current_avatar').is( ":visible" )){
      $('#current_avatar').addClass('hidden')
    }
    if ($('#new_avatar').is( ":hidden" )){
      $('#new_avatar').removeClass('hidden')
    }
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      console.log(img.src)
      $('#preview-avatar').css("background-image", 'url(' + img.src + ')')
    }
    reader.readAsDataURL(image);
  });
});
