class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @outbound_payments = current_user.outbound_payments
    @inbound_payments = current_user.inbound_payments
  end

  def new
    current_user.create_or_update_wallet
    @booking = current_user.bookings.find(params[:booking_id])
    @credit_cards = current_user.credit_cards
    @credit_card = current_user.credit_cards.build
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
    @payment = current_user.payments.build(payment_params)
    @payment.order = current_order
    @payment.amount = current_order.product.price
    @payment.florist = current_order.florist
    @payment.charge

    case @payment.state
    when 'accepted'
      flash[:notice] = "Votre paiement a été accepté"
      redirect_to product_checkout_confirmation_path
    when 'refused'
      raise
      flash[:error] = "Votre paiement a été refusé"
      render :new
    when 'error'
      raise
      flash[:error] = "C'est des teubés chez Mangopay, envoyez un papier-monaie par courrier postal avec recommandé et accusé de réception"
      render :new
    else
      flash[:error] = "42"
      render :new
    end
  end

  private

    def payment_params
      params.require(:payment).permit(:credit_card_id)
    end

    def check_step
      if current_order.may_to_payment?
        current_order.to_payment!
      elsif current_order.cart_status == 'payment'

        return nil
      else
        flash[:error] = 'Une erreur est survenue. Merci de réessayer ou de contacter Blodyn.'

        begin
          redirect_to :back
        rescue ActionController::RedirectBackError
          redirect_to root_path
        end
      end
    end
  end
