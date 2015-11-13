class Desk < ActiveRecord::Base
  extend Enumerize

  belongs_to :company
  has_many :bookings

  enumerize :kind, in: [:open_space, :closed_office, :meeting_room], default: :open_space

end
