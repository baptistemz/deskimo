source 'https://rubygems.org'
ruby '2.2.3'

gem 'rails', '4.2.4'
gem 'pg'
gem 'config'
gem 'figaro'
gem 'jbuilder', '~> 2.0'
gem 'stripe'

gem 'sass-rails', '~> 5.0'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'uglifier'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'autoprefixer-rails'
gem 'turbolinks'
gem 'kaminari'


gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

gem "enumerize"
gem "high_voltage"
gem "devise"
gem "paperclip"
gem "aws-sdk", "< 2.0"
gem "geocoder"
gem 'gmaps4rails'
gem "aasm", '~> 4.2.0'
gem 'money-rails'
gem 'slim'
gem "rails-i18n"
gem "devise-i18n"
gem "devise-i18n-views"
gem 'omniauth-oauth2', '~> 1.3.1' # see https://github.com/intridea/omniauth-oauth2/issues/81
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"
# , '~> 1.3.1'
gem 'google_calendar'
gem 'google-api-client', '~> 0.9', require: 'google/apis/calendar_v3'
gem 'underscore-rails'
gem 'coffee-rails'
gem "pundit"
gem 'searchkick'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'bonsai-elasticsearch-rails'
gem 'sidekiq'
gem 'whenever', :require => false
gem 'sinatra'  # Dependency of sidekiq
gem 'sidekiq-failures'
gem 'sidekiq-scheduler', '~> 2.0'

# gem 'mangopay', '~> 3.0.0'

gem 'js-routes'
gem 'react-rails', '1.6.1'

source 'https://rails-assets.org' do
  gem 'rails-assets-classnames'
end

gem 'activeadmin', github: 'activeadmin'

source 'https://rails-assets.org' do
  gem 'rails-assets-scrollReveal.js'
end


group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'spring', '~> 1.4.1'
  gem "letter_opener"
end

group :test do
  gem 'minitest-rails-capybara'
  gem 'minitest-reporters'
end

# group :staging do
#   gem 'rails_12factor'
#   gem 'puma'
# end

group :production do
  gem 'rails_12factor'
  gem 'puma'
end
