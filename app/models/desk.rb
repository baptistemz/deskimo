class Desk < ActiveRecord::Base
  extend Enumerize

  enumerize :kind, in: [:open_space, :closed_office, :meeting_room], default: :open_space

  belongs_to :company
  has_many :bookings

  after_save :update_company_availability

  private

  def update_company_availability
    company.update_availability
  end
end
