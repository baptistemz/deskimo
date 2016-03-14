class CompanyMailer < ApplicationMailer
  def new_company(company)
    @company = company
    @user = company.user
    mail to: @user.email, subject: 'enregistrement de ' + @company.name
  end

  def paid_booking(booking)
    @booking = booking
    @client = @booking.user
    @desk = @booking.desk
    @company = @desk.company
    @user = @company.user
    mail to: @company.user.email, subject: "Réservation - " + @desk.kind + " n°" + @desk.number.to_s
  end

  def confirmed_booking(booking)
    @booking = booking
    @client = @booking.user
    @desk = @booking.desk
    @company = @desk.company
    @user = @company.user
    mail to: @company.user.email, subject: "Réservation confirmée- " + @desk.kind + " n°" + @desk.number.to_s
  end

  def canceled_booking(booking)
    @booking = booking
    @client = @booking.user
    @desk = @booking.desk
    @company = @desk.company
    @user = @company.user
    mail to: @company.user.email, subject: "Réservation annulée "+ @desk.kind + " n°" + @desk.number.to_s
  end
end

