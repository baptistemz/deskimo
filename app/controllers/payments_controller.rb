class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @outbound_payments = current_user.outbound_payments
    @inbound_payments = current_user.inbound_payments
  end

  def new
    current_user.create_or_update_wallet
    @booking = current_user.bookings.find(params[:booking_id])
    if current_user.credit_card
      @credit_card = current_user.credit_card
    else
      @credit_card = current_user.build_credit_card
    end
    @payment = current_user.outbound_payments.build

    params = {
        UserId: current_user.mangopay_user_id,
        Currency: "EUR",
        CardType: "CB_VISA_MASTERCARD"
      }
    @card_registration = MangoPay::CardRegistration.create(params)
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @payment = current_user.outbound_payments.build(
      credit_card_id: params[:payment][:credit_card],
      receiver_id: @booking.desk.company.user.id,
      booking_id: @booking.id,
      amount_cents: @booking.amount * 100
       )
    @payment.charge

    case @payment.status
    when 'accepted'
      flash[:notice] = "Votre paiement a été accepté"
      redirect_to product_checkout_confirmation_path
    when 'refused'
      raise
      flash[:error] = "Votre paiement a été refusé"
      redirect_to new_booking_payment_path
    when 'error'
      flash[:error] = "C'est des teubés chez Mangopay, envoyez un papier-monaie par courrier postal avec recommandé et accusé de réception"
      redirect_to new_booking_payment_path
    else
      flash[:error] = "42"
      redirect_to new_booking_payment_path
    end
  end
end
