class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user= user
    mail to: @user.email, subject: t("welcome")
  end

  def paid_booking(booking)
    @booking = booking
    @user = @booking.user
    @desk = @booking.desk
    @company = @desk.company
    mail to: @user.email, subject: 'Votre réservation de bureaux chez ' + @company.name
  end

  def confirmed_booking(booking)
    @booking = booking
    @user = @booking.user
    @desk = @booking.desk
    @company = @desk.company
    @welcome_message = @company.welcome_message
    mail to: @user.email, subject: 'Réservation confirmée par ' + @company.name
  end

  def canceled_booking(booking)
    @booking = booking
    @user = @booking.user
    @desk = @booking.desk
    @company = @desk.company
    mail to: @user.email, subject: 'Réservation annulée par ' + @company.name
  end
end


