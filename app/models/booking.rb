class Booking < ActiveRecord::Base
  extend Enumerize

  belongs_to :desk
  belongs_to :user

  validates_presence_of :time_slot_type, :time_slot_quantity, :desk_id, :user_id, :start_date


  validate  :user_cannot_be_from_the_company
  #           # :desk_cannot_be_fully_booked

  enumerize :time_slot_type, in: ["1/2 journée", "jour(s)", "semaine(s)"], default: "jour(s)"
  enumerize :half_day_choice, in: [:am, :pm]
  enumerize :status, in: ["pending", "paid"], default: "pending"

  private

  def user_cannot_be_from_the_company
    errors.add(:user, "Vous ne pouvez pas reserver dans votre entreprise") if
      user == desk.company.user
      raise
  end

  # def desk_cannot_be_fully_booked
  #   errors.add(:desk, "Il n'y a plus de bureau disponible") if
  #     desk.bookings.where(start_date)
  # end
end
