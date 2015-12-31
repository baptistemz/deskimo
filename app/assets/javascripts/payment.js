$('#create-card').click(function(){
  $('.card-creation').toggleClass('hidden')
});
$('#payment_credit_card_id').change(function(){
  if ($('#payment_credit_card_id').val() != ''){
    $('#payment-btn').removeClass('disabled')
  }else{
    $('#payment-btn').addClass('disabled')
  };
});
$('#payment-btn').click()
