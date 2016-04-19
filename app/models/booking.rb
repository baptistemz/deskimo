class Booking < ActiveRecord::Base
  extend ActiveModel::Naming
  extend Enumerize

  belongs_to :desk
  belongs_to :user
  has_one :unavailability_range, dependent: :destroy
  has_one :invoice, dependent: :nullify

  validates_presence_of :time_slot_type, :time_slot_quantity, :desk_id, :user_id, :start_date
  validates :time_slot_quantity, :numericality => { :greater_than => 0 }
  validate  :user_cannot_be_from_the_company
  validate  :desk_must_be_available, on: :create
  validate  :user_must_have_names, on: :update

  monetize :amount_cents

  enumerize :time_slot_type, in: [:half_day, :'day(s)', :'week(s)'], default: :'day(s)'
  enumerize :half_day_choice, in: [:am, :pm]
  enumerize :status, in: [:pending, :identified, :paid, :confirmed, :canceled], default: :pending

  after_update :booking_status_management

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

  def user_must_have_names
    errors.add(:first_name,"Vous ne pouvez pas passer de commande sans indiquer votre prénom") if
      user.first_name.to_s == ''
    errors.add(:last_name,"Vous ne pouvez pas passer de commande sans indiquer votre nom") if
      user.last_name.to_s == ''
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

  def booking_status_management
    unless self.archived
      if self.status == :paid
        send_booking_emails
        if self.desk.calendar_id
          CreateGoogleCalendarEventJob.perform_later(self.id)
        end
      elsif self.status == :canceled
        send_booking_emails
        if self.desk.calendar_id
          DeleteGoogleCalendarEventJob.perform_later(self.id)
        end
      end
    end
  end

  def send_booking_emails
    CompanyMailer.send("#{self.status}_booking", self).deliver_later
    UserMailer.send("#{self.status}_booking", self).deliver_later
  end

  # def create_google_calendar_event
  #   @event = {
  #     'summary' => 'Reservation deskimo',
  #     'description' => 'Réservé par #{self.user.first_name} #{self.user.last_name}, statut:#{self.status.text}',
  #     'location' => self.desk.company.full_address,
  #     'start' => { 'dateTime' => Chronic.parse('tomorrow 4 pm') },
  #     'end' => { 'dateTime' => Chronic.parse('tomorrow 5pm') },
  #     'attendees' => [ { "email" => self.user.email } ]
  #     }

  #   client = Google::APIClient.new
  #   client.authorization.access_token = self.desk.company.user.google_token
  #   service = client.discovered_api('calendar', 'v3')

  #   @set_event = client.execute(:api_method => service.events.insert,
  #                           :parameters => {'calendarId' => current_user.email, 'sendNotifications' => true},
  #                           :body => JSON.dump(@event),
  #                           :headers => {'Content-Type' => 'application/json'})
  # end
end
