$('.minus-button').click(function() {
  var $button = $(this)
  var oldValue = $button.parent().find(".numeric").val();
  var newVal = parseFloat(oldValue) - 1;
  $button.parent().find(".numeric").val(newVal);
});

$('.plus-button').click(function() {
  var $button = $(this)
  var oldValue = $button.parent().find(".numeric").val();
  var newVal = parseFloat(oldValue) + 1;
  $button.parent().find(".numeric").val(newVal);
});
