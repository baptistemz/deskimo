class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking

  def index
    @outbound_payments = current_user.outbound_payments
    @inbound_payments = current_user.inbound_payments
  end

  def new
    @company = @booking.desk.company
    @desk = @booking.desk
    # current_user.create_or_update_wallet
    # if current_user.credit_card
    #   @credit_card = current_user.credit_card
    # else
    #   @credit_card = current_user.build_credit_card
    # end
    # @payment = current_user.outbound_payments.build

    # params = {
    #     UserId: current_user.mangopay_user_id,
    #     Currency: "EUR",
    #     CardType: "CB_VISA_MASTERCARD"
    #   }
    # @card_registration = MangoPay::CardRegistration.create(params)
  end

  def create
    @company = @booking.desk.company
    @amount = @booking.amount_cents
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email: params[:stripeEmail]
    )
    current_user.update(stripe_customer_id: customer.id)

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount:       @amount,  # in cents
      description:  "Location de bureaux chez #{@company.name} ",
      currency:     'eur'
    )

    @booking.update(status: 'paid', payment: charge.to_json)
    @booking.build_invoice(payment: charge.to_json).save
    redirect_to account_booking_path(@booking)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_booking_payment_path(@booking)



    # @payment = current_user.outbound_payments.build(
    #   credit_card_id: params[:payment][:credit_card],
    #   receiver_id: @booking.desk.company.user.id,
    #   booking_id: @booking.id,
    #   amount_cents: @booking.amount * 100
    #    )
    # @payment.charge

    # case @payment.status
    # when 'accepted'
    #   flash[:notice] = "Votre paiement a été accepté"
    #   redirect_to product_checkout_confirmation_path
    # when 'refused'
    #   flash[:error] = "Votre paiement a été refusé"
    #   redirect_to new_booking_payment_path
    # when 'error'
    #   flash[:error] = "C'est des teubés chez Mangopay, envoyez un papier-monaie par courrier postal avec recommandé et accusé de réception"
    #   redirect_to new_booking_payment_path
    # else
    #   flash[:error] = "42"
    #   redirect_to new_booking_payment_path
    # end
  end

  private

  def set_booking
    @booking = current_user.bookings.where(status: 'pending').find(params[:booking_id])
  rescue
    flash[:alert] = t('checkout.time_expiry')
    redirect_to root_path
  end
end
