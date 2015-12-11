class Desk < ActiveRecord::Base

  extend Enumerize

  enumerize :kind, in: [:open_space, :closed_office, :meeting_room], default: :open_space

  belongs_to :company
  has_many :bookings

  has_many :unavailability_ranges

  after_commit :reindex_product

  def get_next_available_days_array
    available_days = []
    self.company.get_next_opening_days_array.each do |day|
      @booked = self.unavailability_ranges.where('start_date <= ? AND end_date >= ?', day, day)
      if @booked.length < self.quantity
        available_days<< day
      end
    end
    return available_days
  end

  def reindex_company
    company.reindex
  end

  private

end
