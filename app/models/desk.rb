class Desk < ActiveRecord::Base
  extend ActiveModel::Naming
  extend Enumerize


  belongs_to :company
  has_many :bookings

  has_many :unavailability_ranges, dependent: :destroy

  validates_presence_of :quantity, :description, :half_day_price, :daily_price, :weekly_price
  validates :quantity, :half_day_price, :daily_price, :weekly_price, :capacity, numericality: {greater_than_or_equal_to: 1}

  monetize :hour_price_cents, :half_day_price_cents, :daily_price_cents, :weekly_price_cents
  enumerize :kind, in: [:open_space, :closed_office, :meeting_room], default: :open_space
  validate  :one_open_space_maximum
  validate  :three_desks_of_each_kind_maximum
  validates_uniqueness_of :number, scope: [:company_id, :kind]
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

  def one_open_space_maximum
    errors.add(:kind, "Vous avez déjà un open space, ajoutez-y des places") if
      company.desks.where(kind: "open_space").any? && kind == "open_space"
  end

  def three_desks_of_each_kind_maximum
    if id
      if company.desks.where(kind: kind).length >= 4
        errors.add(:kind, "Vous avez déjà atteint le maximum de bureaux de ce type (3)")
      end
    else
      if company.desks.where(kind: kind).length >= 3
        errors.add(:kind, "Vous avez déjà atteint le maximum de bureaux de ce type (3)")
      end
    end
  end

  def update_company_cheapest_price
    company.update_cheapest_desk_price
  end

  def reindex_company
    company.reindex
  end
end


