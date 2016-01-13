class Booking < ActiveRecord::Base
  extend Enumerize

  belongs_to :desk
  belongs_to :user
  has_one :unavailability_range, dependent: :destroy

  validates_presence_of :time_slot_type, :time_slot_quantity, :desk_id, :user_id, :start_date
  validate  :user_cannot_be_from_the_company
  validate  :desk_must_be_available

  monetize :amount_cents

  enumerize :time_slot_type, in: [:half_day, :'day(s)', :'week(s)'], default: :'day(s)'
  enumerize :half_day_choice, in: [:am, :pm]
  enumerize :status, in: [:pending, :paid, :confirmed, :canceled], default: "pending"

  private

  def user_cannot_be_from_the_company
    errors.add(:start_date,"Vous ne pouvez pas reserver dans votre entreprise") if
      user == desk.company.user
  end

  def desk_must_be_available
    if start_date == end_date
      errors.add(:start_date, "Ce bureau n'est plus disponible à cette dates") unless
        desk.get_next_available_days_array.include?(start_date)

    else
      errors.add(:start_date, "Ce bureau n'est plus disponible à ces dates") unless
        [start_date, end_date] & desk.get_next_available_days_array == [start_date, end_date]

    end
  end
end
