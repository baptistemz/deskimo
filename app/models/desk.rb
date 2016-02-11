class Desk < ActiveRecord::Base
  extend ActiveModel::Naming
  extend Enumerize


  belongs_to :company
  has_many :bookings

  has_many :unavailability_ranges, dependent: :destroy

  validates_presence_of :quantity, :description, :half_day_price, :daily_price, :weekly_price

  monetize :hour_price_cents, :half_day_price_cents, :daily_price_cents, :weekly_price_cents
  enumerize :kind, in: [:open_space, :closed_office, :meeting_room], default: :open_space
  validates_uniqueness_of :kind, scope: :company_id
  after_commit :reindex_company
  after_create :update_company_cheapest_price
  after_update :update_company_cheapest_price

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

  private

  def update_company_cheapest_price
    company.update_cheapest_desk_price
  end

  def reindex_company
    company.reindex
  end
end
