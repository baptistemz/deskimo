module Account
  class CreditCardController < ApplicationController
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
      @credit_card = current_user.build_credit_card(token: params[:mangopay_card_id])
      @credit_card.name = params[:card_holder]
      @credit_card.expires_at = Date.new(params[:card_exp_year].prepend('20').to_i, params[:card_exp_month].to_i, 29)
      if @credit_card.save
        redirect_to new_booking_payment_path(params[:booking_id])
      else
        redirect_to :back
      end
    end
  end
end
