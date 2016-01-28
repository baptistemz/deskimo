class CompanyMailer < ApplicationMailer
  def new_company(company)
    @company = company
    @user = company.user
    mail to: @user.email, subject: 'enregistrement de ' + @company.name
  end

  def booking_recorded(booking)
    @booking = booking
    @client = @booking.user
    @desk = @booking.desk
    @company = @booking.desk.company
    @user = @company.user
    mail to: @company.user.email, subject: "Réservation de bureaux chez " + @company.name
  end
end
