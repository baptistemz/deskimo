$(document).ready(function(){
    var preview = $("#preview-image");

  $('.file').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      $('#preview-image').css("background-image", 'url(' + img.src + ')')
    }
    reader.readAsDataURL(image);
  });
  // $('#input-company-name').keyup(function(){
  //   var name = $('#input-company-name').val();
  //   console.log(name)
  //   $('#company-name-preview').html(name)
  // });

  $("#company_name").keyup(function(){
    var name = this.value;
    $('#company-name-preview').text(name)
  });

});


