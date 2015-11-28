$('#minus-button').click(function() {
  var $button = $(this)
  var oldValue = $button.parent().find("#desk_quantity").val();
  var newVal = parseFloat(oldValue) - 1;
  $button.parent().find("#desk_quantity").val(newVal);
});

$('#plus-button').click(function() {
  var $button = $(this)
  var oldValue = $button.parent().find("#desk_quantity").val();
  var newVal = parseFloat(oldValue) + 1;
  $button.parent().find("#desk_quantity").val(newVal);
});
