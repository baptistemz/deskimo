MyApp::Application.configure do
  config.middleware.use '::Rack::Auth::Basic' do |u, p|
    [u, p] == [ENV['MY_SITE_USERNAME'], ENV['MY_SITE_SECRET']]
  end

 #... other config
end
