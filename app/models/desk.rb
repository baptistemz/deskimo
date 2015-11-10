class Desk < ActiveRecord::Base
  belongs_to :workplace
  has_many :bookings
end
