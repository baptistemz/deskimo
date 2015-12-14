class Payment < ActiveRecord::Base
  extend Enumerize
  has_one :credit_card

  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :payer, class_name: 'User', foreign_key: :payer_id

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
