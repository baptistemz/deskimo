class UpdateCalendarJob < ActiveJob::Base
  queue_as :default

  def perform
    @desks = Desk.where("desks.calendar_id IS NOT NULL")
    @desks.each do |desk|
      if desk.company.user.calendar_refresh_token
        @freebusy = desk.get_next_calendar_events
        desk.create_and_delete_unavailabilities(@freebusy)
      end
    end
  end
end
