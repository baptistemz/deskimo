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
    $('#company_name').keyup(function(){
      var name = $('#company_name').val();
      $('#company-name-preview').html(name)
    });


    $('#company_wifi').click(function() {
        if ($(this).is(':checked')) {
            $('#wifi-badge').removeClass('hidden');

        } else {
            $('#wifi-badge').addClass('hidden');
        }
    });

        $('#company_coffee').click(function() {
        if ($(this).is(':checked')) {
            $('#coffee-badge').removeClass('hidden');

        } else {
            $('#coffee-badge').addClass('hidden');
        }
    });

        $('#company_printer').click(function() {
        if ($(this).is(':checked')) {
            $('#printer-badge').removeClass('hidden');

        } else {
            $('#printer-badge').addClass('hidden');
        }
    });


});


