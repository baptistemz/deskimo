class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user= user
    if @user.company
      @company = @user.company
    end
    mail to: @user.email, subject: t("mailer.welcome")
  end
end
