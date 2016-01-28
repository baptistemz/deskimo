class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user= user
    mail to: @user.email, subject: t("mailer.welcome")
  end

  def booking_confirmation(booking)
    @booking = booking
    @user = @booking.user
    @desk = @booking.desk
    @company = @booking.desk.company
    mail to: @company.user.email, subject: 'Votre réservation de bureaux chez ' + @company.name
  end
end
