class Booking < ActiveRecord::Base
  extend Enumerize

  belongs_to :desk
  belongs_to :user

  validates_presence_of :time_slot_type, :time_slot_quantity, :desk_id, :user_id, :start_date


  validate  :user_cannot_be_from_the_company
  validate  :desk_must_be_available

  enumerize :time_slot_type, in: ["1/2 journée", "jour(s)", "semaine(s)"], default: "jour(s)"
  enumerize :half_day_choice, in: [:am, :pm]
  enumerize :status, in: ["pending", "paid"], default: "pending"

  private

  def user_cannot_be_from_the_company
    errors.add(:user, "Vous ne pouvez pas reserver dans votre entreprise") if
      user == desk.company.user
  end

  def desk_must_be_available
    errors.add(:desk, "Ce bureau n'est plus disponible à ces dates") if
      (start_date..end_date).to_a & desk.get_next_available_days_array == []
  end
end
