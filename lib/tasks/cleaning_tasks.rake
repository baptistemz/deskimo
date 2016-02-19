desc 'clean unavailabilities if they are passed'
task clean_unavailabilities: :environment do
  # ... set options if any
  CleanOldUnavailabilitiesJob.perform_later
end
