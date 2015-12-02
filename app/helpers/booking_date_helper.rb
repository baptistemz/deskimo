module BookingDateHelper
  require 'date'

  def options_for_booking_date(opening_days)
    opening_days.each do |day|
      day_id    = day.strftime('%A %d-%m-%Y')
      [day_id, day]
    end
  end
end
