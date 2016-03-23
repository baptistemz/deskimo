class Desk < ActiveRecord::Base
  extend ActiveModel::Naming
  extend Enumerize


  belongs_to :company
  has_many :bookings, dependent: :nullify

  has_many :unavailability_ranges, dependent: :destroy

  validates_presence_of :quantity, :description, :half_day_price, :daily_price, :weekly_price
  validates :quantity, :half_day_price, :daily_price, :weekly_price, :capacity, numericality: {greater_than_or_equal_to: 1}
  validates_length_of :description, :maximum => 220

  monetize :hour_price_cents, :half_day_price_cents, :daily_price_cents, :weekly_price_cents
  enumerize :kind, in: [:open_space, :closed_office, :meeting_room], default: :open_space
  validate  :one_open_space_maximum, on: :create
  validate  :six_desks_of_each_kind_maximum
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

  def name
    if self.kind == :open_space
      self.kind.text
    else
      "#{self.kind.text} n° #{self.number}"
    end
  end

  def create_and_delete_unavailabilities(events)
    events.each do |event|
      if event.raw['start']['dateTime']
        self.unavailability_ranges.where(start_date: event.raw['start']['dateTime'].to_date,
                                         end_date: event.raw['end']['dateTime'].to_date).first_or_create(kind: :calendar)
      elsif event.raw['start']['date']
        self.unavailability_ranges.where(start_date: (event.raw['start']['date'].to_date),
                                         end_date: (event.raw['end']['date'].to_date - 1.day)).first_or_create(kind: :calendar)
      end

    end
    self.unavailability_ranges.where(kind: :calendar).each do |u_r|
      @associated = events.find do |event|
        if event.raw['start']['dateTime']
          event.raw['start']['dateTime'].to_date == u_r.start_date && event.raw['end']['dateTime'].to_date == u_r.end_date
        elsif event.raw['start']['date']
          event.raw['start']['date'].to_date == u_r.start_date && (event.raw['end']['date'].to_date - 1.day) == u_r.end_date
        end
      end
      u_r.delete unless @associated
    end
  end

  def get_next_calendar_events
    # freebusy_data = Google::Freebusy.new(client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
    #                                      client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
    #                                      refresh_token:     self.company.user.calendar_refresh_token,
    #                                      redirect_url: "urn:ietf:wg:oauth:2.0:oob" # this is what Google uses for 'applications'
    #                                      )
    # @freebusy = freebusy_data.query([self.calendar_id], Time.now, (Time.now + 30.days))[self.calendar_id]
    calendar = initialize_calendar
    calendar.login_with_refresh_token(self.company.user.calendar_refresh_token)
    @events = calendar.find_events_in_range(Time.now, (Time.now + 30.days))
  end

  def create_google_calendar_event(booking)
    calendar = initialize_calendar
    calendar.login_with_refresh_token(self.company.user.calendar_refresh_token)
    event = calendar.create_event do |e|
      e.title = "réservation deskimo - #{booking.user.first_name} #{booking.user.last_name}"
      if booking.time_slot_type == 'half_day'
        if booking.half_day_choice == 'am'
          d = booking.start_date
          st = self.company.start_time_am
          et = self.company.end_time_am
          e.start_time = Time.zone.parse(DateTime.new(d.year, d.month, d.day, st.hour, st.min, st.sec, '+2').to_s)
          e.end_time = Time.zone.parse(DateTime.new(d.year, d.month, d.day, et.hour, et.min, et.sec, '+2').to_s)
        elsif booking.half_day_choice == 'pm'
          d = booking.start_date
          st = self.company.start_time_pm
          et = self.company.end_time_pm
          e.start_time = Time.zone.parse(DateTime.new(d.year, d.month, d.day, st.hour, st.min, st.sec, '+2').to_s)
          e.end_time = Time.zone.parse(DateTime.new(d.year, d.month, d.day, et.hour, et.min, et.sec, '+2').to_s)
        end
      else
        sd = booking.start_date
        st = self.company.start_time_am
        ed = booking.end_date
        et = self.company.end_time_pm
        e.start_time = Time.zone.parse(DateTime.new(sd.year, sd.month, sd.day, st.hour, st.min, st.sec, '+2').to_s)
        e.end_time = Time.zone.parse(DateTime.new(ed.year, ed.month, ed.day, et.hour, et.min, et.sec, '+2').to_s)
        # sd = start date ; ed = end date ; st = start time ; et = end time
      end
    end
    booking.unavailability_range.update(calendar_event_id: event.id)
  end

  def delete_google_calendar_event(booking)
    calendar = initialize_calendar
    calendar.login_with_refresh_token(self.company.user.calendar_refresh_token)
    event = calendar.find_or_create_event_by_id(booking.unavailability_range.calendar_event_id)
    event.delete
  end

  private

  def initialize_calendar
    Google::Calendar.new(client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
                         client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
                         calendar:  self.calendar_id,
                         redirect_url: "urn:ietf:wg:oauth:2.0:oob" # this is what Google uses for 'applications'
                         )
  end

  def one_open_space_maximum
    errors.add(:kind, "Vous avez déjà un open space, ajoutez-y des places") if
      company.desks.where(kind: "open_space").any? && kind == "open_space"
  end

  def six_desks_of_each_kind_maximum
    if id
      if company.desks.where(kind: kind).length >= 7
        errors.add(:kind, "Vous avez déjà atteint le maximum de bureaux de ce type (3)")
      end
    else
      if company.desks.where(kind: kind).length >= 6
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


