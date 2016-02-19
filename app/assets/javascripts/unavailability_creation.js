// $(document).ready(function{
//   $('#new_unavailability_range')
// })

$('#new_unavailability_range').submit(function(){
  $('.submit-dates').attr("name", "quantity")
  $('.submit-dates').attr("value", $('.integer-input').val())
})
