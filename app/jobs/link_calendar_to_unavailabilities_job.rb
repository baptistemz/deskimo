class LinkCalendarToUnavailabilitiesJob < ActiveJob::Base
  queue_as :default

  # Receive last and current occurrence times.
  def perform(desk_id)
    @desk = Desk.find(desk_id)
    @events = @desk.get_next_calendar_events
    @desk.create_and_delete_unavailabilities(@events)
  end
end
