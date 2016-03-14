class CleanUnpaidBookingsJob < ActiveJob::Base
  queue_as :default

  def perform(booking_id)
    @booking = Booking.find(booking_id)
    if @booking.status == 'pending'
      @booking.unavailability_range.destroy
      @booking.update(status: 'canceled', archived: true)
    end
  end
end
