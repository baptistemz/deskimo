module Account
  class CreditCardsController < ApplicationController
    def index
      @credit_cards = current_user.credit_cards
    end

    def new
      current_user.create_or_update_wallet
      @last_order = current_user.orders.last
      params = {
        UserId: current_user.mangopay_user_id,
        Currency: "EUR",
        CardType: "CB_VISA_MASTERCARD"
      }

      @card_registration = MangoPay::CardRegistration.create(params)
    end

    def create
      @credit_card = current_user.credit_cards.build(token: params[:mangopay_card_id])
      @credit_card.name = params[:name]
      if @credit_card.save
        redirect_to new_booking_payment_path(@booking)
      else
        redirect_to :back
      end
    end
  end
end
