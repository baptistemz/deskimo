class CleanOldUnavailabilitiesJob < ActiveJob::Base
  queue_as :default

  # Receive last and current occurrence times.
  def perform
    @today = Date.today
    @unavailabilities = UnavailabilityRange.where("end_date < ?", @today)
    @unavailabilities.destroy_all
  end
end
