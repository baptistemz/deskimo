$(document).ready(function(){
  $("#desk_half_day_price").keyup(function(){
    var totalprice = $(this).val();
    var tva = (totalprice * 0.2).toFixed(2);
    var company = ((totalprice - tva) * 0.85).toFixed(2);
    var no = ((totalprice - tva) * 0.15).toFixed(2);
    $("#half_day_totalprice").html(totalprice);
    $("#half_day_tva").html(tva);
    $("#half_day_company_amount").html(company);
    $("#half_day_no_amount").html(no);
  });

  $("#desk_daily_price").keyup(function(){
    var totalprice = $(this).val();
    var tva = (totalprice * 0.2).toFixed(2);
    var company = ((totalprice - tva) * 0.85).toFixed(2);
    var no = ((totalprice - tva) * 0.15).toFixed(2);
    $("#daily_totalprice").html(totalprice);
    $("#daily_tva").html(tva);
    $("#daily_company_amount").html(company);
    $("#daily_no_amount").html(no);
  });

  $("#desk_weekly_price").keyup(function(){
    var totalprice = $(this).val();
    var tva = (totalprice * 0.2).toFixed(2);
    var company = ((totalprice - tva) * 0.85).toFixed(2);
    var no = ((totalprice - tva) * 0.15).toFixed(2);
    $("#weekly_totalprice").html(totalprice);
    $("#weekly_tva").html(tva);
    $("#weekly_company_amount").html(company);
    $("#weekly_no_amount").html(no);
  });
});
