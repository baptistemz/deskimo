require 'sidekiq/scheduler'
require 'sidekiq/web'
require 'sidekiq-scheduler/web'


Sidekiq.schedule = YAML.load_file(Rails.root.join('config/sidekiq-scheduler.yml'))

# Sidekiq::Web.use Rack::Auth::Basic do |username, password|
#   username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
# end
