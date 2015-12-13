module Account
  class CreditCardsController < ApplicationController
    def index
      @credit_cards = current_user.credit_cards
    end

    def new
      current_user.create_or_update_wallet
      # @last_booking = current_user.bookings.last


      params = {
        UserId: current_user.mangopay_user_id,
        Currency: "EUR",
        CardType: "CB_VISA_MASTERCARD"
      }

      @card_registration = MangoPay::CardRegistration.create(params)
    end

    def create
      @credit_card = current_user.credit_cards.build(token: params[:mangopay_card_id])
      @credit_card.name = "Votre carte de crédit n°#{params[:mangopay_card_id]}"
      @last_booking = current_user.bookings.last
      if @credit_card.save
        if @last_booking.cart_status == 'payment'
          redirect_to new_product_checkout_payment_path(@last_booking.product)
        else
          redirect_to account_credit_cards_path
        end
      else
        redirect_to new_account_credit_card_path
      end
    end
  end
end
