$(document).ready(function(){
  $("#desk_hour_price").keyup(function(){
    var totalprice = $(this).val();
    var tva = (totalprice * 0.2).toFixed(2);
    var company = ((totalprice - tva) * 0.85).toFixed(2);
    var no = ((totalprice - tva) * 0.15).toFixed(2);
    $("#hour_totalprice").html(totalprice);
    $("#hour_tva").html(tva);
    $("#hour_company_amount").html(company);
    $("#hour_no_amount").html(no);
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
