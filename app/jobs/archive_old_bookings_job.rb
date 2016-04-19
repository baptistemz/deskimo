class ArchiveOldBookingsJob < ActiveJob::Base
  queue_as :default

  # Receive last and current occurrence times.
  def perform
    @limit = Date.today - 7.days
    @bookings = Booking.where("end_date < ?", @limit)
    @bookings.each do |booking|
      booking.update_attribute(:archived, true)
      if booking.status == :pending || booking.status == :identified
        booking.update_attribute(:status, 'canceled')
      end
    end
  end
end
