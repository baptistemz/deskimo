class Payment < ActiveRecord::Base
  has_one :credit_card
  has_one :payer, class_name: "User"
  has_one :receiver, class_name: "User"

  enumerize :status, in: %w(pending paid canceled error), default: :pending

  def charge
    mangopay_request = {
      AuthorId: self.receiver.mangopay_user_id,
      DebitedFunds: {
          Currency: "EUR",
          Amount: self.amount_cents
      },
        Fees: {
          Currency: "EUR",
          Amount: self.amount_cents * 0.10
      },
      CreditedWalletId: self.payer.mangopay_wallet_id,
      CardId: self.credit_card.token,
      SecureModeReturnURL: 'https://www.elysee.fr'
    }

    begin
      response = MangoPay::PayIn::Card::Direct.create(mangopay_request)
      self.response = response
      self.mangopay_payin_id = response["Id"]

      if response["Status"] == 'SUCCEEDED'
        self.state = :accepted
        self.order.validate_payment!
      else
        self.state = :refused
      end
    rescue MangoPay::ResponseError => e
      self.response = e.details
      self.state = :error
    end

    self.save
  end
end
