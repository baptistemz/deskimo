class Booking < ActiveRecord::Base
  extend ActiveModel::Naming
  extend Enumerize

  belongs_to :desk
  belongs_to :user
  has_one :unavailability_range, dependent: :destroy
  has_one :invoice

  validates_presence_of :time_slot_type, :time_slot_quantity, :desk_id, :user_id, :start_date
  validate  :user_cannot_be_from_the_company
  validate  :desk_must_be_available, on: :create

  monetize :amount_cents

  enumerize :time_slot_type, in: [:half_day, :'day(s)', :'week(s)'], default: :'day(s)'
  enumerize :half_day_choice, in: [:am, :pm]
  enumerize :status, in: ["pending", "paid", "confirmed", "canceled"], default: "pending"

  def set_amount_and_dates
    next_available_days = self.desk.get_next_available_days_array
    if self.time_slot_type == "half_day"
      self.end_date = self.start_date
      self.amount = self.desk.half_day_price
    elsif self.time_slot_type == "day(s)"
      booking_day_number = next_available_days.find_index(self.start_date)
      self.end_date = next_available_days[booking_day_number + self.time_slot_quantity - 1]
      self.amount = self.desk.daily_price * self.time_slot_quantity
    else
      self.end_date = self.start_date + (7 * self.time_slot_quantity).days
      self.amount = self.desk.weekly_price * self.time_slot_quantity
    end
  end


  private

  def user_cannot_be_from_the_company
    errors.add(:start_date,"Vous ne pouvez pas reserver dans votre entreprise") if
      user == desk.company.user
  end

  def desk_must_be_available
    if start_date == end_date
      errors.add(:start_date, "Ce bureau n'est plus disponible à cette date") unless
        desk.get_next_available_days_array.include?(start_date)

    else
      errors.add(:start_date, "Ce bureau n'est plus disponible à ces dates") unless
        [start_date, end_date] & desk.get_next_available_days_array == [start_date, end_date]
    end
  end
end
