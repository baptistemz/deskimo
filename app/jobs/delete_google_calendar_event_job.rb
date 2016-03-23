class DeleteGoogleCalendarEventJob < ActiveJob::Base
  queue_as :default

  # Receive last and current occurrence times.
  def perform(booking_id)
    @booking = Booking.find(booking_id)
    @booking.desk.delete_google_calendar_event(@booking)
  end
end
