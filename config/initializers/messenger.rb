Messenger.configure do |config|
  config.verify_token      = ENV['FB_VERIFY_TOKEN'] #will be used in webhook verifiction
  config.page_access_token = ENV['FB_PAGE_ACCESS_TOKEN']
end
