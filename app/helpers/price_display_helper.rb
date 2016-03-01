module PriceDisplayHelper
  def cheapest_daily_price(desks)
    desks.minimum(:daily_price_cents) / 100
  end

  def cheapest_desk_kind(desks)
  end
end
