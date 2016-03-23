class LinkCalendarToUnavailabilitiesJob < ActiveJob::Base
  queue_as :default

  # Receive last and current occurrence times.
  def perform(desk_id)
    @desk = Desk.find(desk_id)
    @freebusy = @desk.get_next_calendar_events
    @desk.create_and_delete_unavailabilities(@freebusy)
  end
end
