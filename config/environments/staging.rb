MyApp::Application.configure do
  config.middleware.insert_after(::Rack::Lock, "::Rack::Auth::Basic", "Staging") do |u, p|
    [u, p] == [ENV['MY_SITE_USERNAME'], ENV['MY_SITE_SECRET']]
  end

 #... other config
end
