class ApplicationMailer < ActionMailer::Base
  default from: Settings.mails.default.from
  layout 'mailer'
end
