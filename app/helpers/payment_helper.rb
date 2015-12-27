module PaymentHelper
  def cc_years
    yrs = []
    year_today = Date.today.strftime("%y").to_i
    year_today.upto(year_today+10).each do |y| yrs << y.to_s;end
    return yrs
  end
end
