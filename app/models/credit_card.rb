class CreditCard < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :payment

  has_many
end
