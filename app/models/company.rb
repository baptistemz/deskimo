class Company < ActiveRecord::Base
  require 'elasticsearch/model'
  searchkick locations: ["location"], settings: {number_of_shards: 1}

  belongs_to :user
  has_many :desks, dependent: :destroy
  has_many :closing_days, dependent: :destroy
  has_one :welcome_message, dependent: :destroy
  has_attached_file :picture,
    styles: {list: "400x200#", show: "740x370#"}
    # rake paperclip:refresh CLASS=Company

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/
  validates_presence_of :name, :address, :city, :description, :postcode, :picture, :phone_number

  monetize :cheapest_desk_price_cents
  geocoded_by :full_address

  after_validation :geocode, if: :full_address_changed?
  after_create :send_new_company_email

  def search_data
    {
      activated:        activated,
      name:             name,
      location:         [latitude, longitude],
      kinds:            desks.where(activated: true).pluck(:kind),
      desk_ids:         desk_ids,
      half_day_prices:  desks.pluck(:half_day_price),
      daily_prices:     desks.pluck(:daily_price),
      weekly_prices:    desks.pluck(:weekly_price)
    }
  end

  def update_activation
    enabled_desks = desks.where(activated: true).any?
    if enabled_desks != activated
      toggle!(:activated)
    end
  end

  def get_opening_weekdays_range
    if self.open_monday &&
       self.open_tuesday &&
       self.open_wednesday &&
       self.open_thursday &&
       self.open_friday &&
       self.open_saturday &&
       self.open_sunday
      @opening_weekdays_range = []
    else
      @opening_weekdays_range = [which_day(true), which_day(false)]
    end
  end

  def get_next_opening_days_array
    weekdays = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
    @opening_days = []
    @today = Date.today.strftime('%A').downcase
    if self.send(:"open_#{@today}")
      @opening_days << Date.today
    end
    weekday_counter = 0
    7.times do
      add_if_open_weekday(weekdays[weekday_counter])
      weekday_counter +=1
    end
    @opening_days.sort
  end

  def add_if_open_weekday(weekday)
    if self.send(:"open_#{weekday}")
      week_counter = 0
      4.times do
        @opening_days << date_of_next(weekday) + week_counter
        week_counter +=7
      end
    end
  end

  def get_opening_hours_range
    @hour_range = [self.start_time_am.strftime("%I:%M%p"), self.end_time_am.strftime("%I:%M%p")]
    @hour_range << self.start_time_pm.strftime("%I:%M%p") if self.start_time_pm
    @hour_range << self.end_time_pm.strftime("%I:%M%p") if self.end_time_pm
  end

  def update_cheapest_desk_price
    activated_desks = desks.where(activated: :true)
    if activated_desks.any?
      self.update(cheapest_desk_price_cents: activated_desks.minimum(:daily_price_cents))
    end
  end

  def full_address
    return "#{address},#{postcode},#{city},France"
  end

  private

  def send_new_company_email
    CompanyMailer.new_company(self).deliver_later
  end

  def date_of_next(weekday)
    date  = Date.parse(weekday)
    delta = date > Date.today ? 0 : 7
    date + delta
  end

  def which_day(boolean)
    weekdays = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
    weekdays.each do |weekday|
      if self.send(:"open_#{weekday}") == boolean
        if boolean == true
          return ending = weekday
        else
          return ending = weekdays[weekdays.index(weekday) - 1]
        end
      end
    end
  end


  def full_address_changed?
    address_changed? || city_changed? || postcode_changed?
  end
end
