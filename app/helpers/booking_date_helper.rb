module BookingDateHelper
  require 'date'

  def options_for_booking_date(opening_days)
    opening_days.each do |day|
      day = l(day)
    end
  end
end
