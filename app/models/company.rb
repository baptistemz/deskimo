class Company < ActiveRecord::Base
  require 'elasticsearch/model'
  searchkick locations: ["location"]
  searchkick settings: {number_of_shards: 1}

  belongs_to :user
  has_many :desks, dependent: :destroy

  has_attached_file :picture,
    styles: { large: "500x500", medium: "300x300>", thumb: "100x100>" , list: "800x400#"}
    # rake paperclip:refresh CLASS=Company

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  validates_presence_of :name, :siret, :address, :city, :description

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  def search_data
    {
      activated:        activated,
      name:             name,
      location:         [latitude, longitude],
      kinds:            desks.pluck(:kind),
      desk_ids:         desk_ids,
      half_day_prices:  desks.pluck(:half_day_price),
      daily_prices:     desks.pluck(:daily_price),
      weekly_prices:    desks.pluck(:weekly_price)
    }
  end

  def get_opening_days_string
    if self.open_monday &&
       self.open_tuesday &&
       self.open_wednesday &&
       self.open_thursday &&
       self.open_friday &&
       self.open_saturday &&
       self.open_sunday
      day_string = 'Ouvert toute la semaine'
    else
      starting = get_starting_day
      ending = get_ending_day
      day_string = starting + ending
    end
    return day_string
  end

  def get_next_opening_days_array
    opening_days = []
    @today = Date.today.strftime('%A').downcase
    if self.send(:"open_#{@today}")
      opening_days << Date.today
    end
    if self.open_monday
      opening_days << date_of_next('monday')
      opening_days << date_of_next('monday') + 7
      opening_days << date_of_next('monday') + 14
      opening_days << date_of_next('monday') + 21
    end
    if self.open_tuesday
      opening_days << date_of_next('tuesday')
      opening_days << date_of_next('tuesday') + 7
      opening_days << date_of_next('tuesday') + 14
      opening_days << date_of_next('tuesday') + 21
    end
    if self.open_wednesday
      opening_days << date_of_next('wednesday')
      opening_days << date_of_next('wednesday') + 7
      opening_days << date_of_next('wednesday') + 14
      opening_days << date_of_next('wednesday') + 21
    end
    if self.open_thursday
      opening_days << date_of_next('thursday')
      opening_days << date_of_next('thursday') + 7
      opening_days << date_of_next('thursday') + 14
      opening_days << date_of_next('thursday') + 21
    end
    if self.open_friday
      opening_days << date_of_next('friday')
      opening_days << date_of_next('friday') + 7
      opening_days << date_of_next('friday') + 14
      opening_days << date_of_next('friday') + 21
    end
    if self.open_saturday
      opening_days << date_of_next('saturday')
      opening_days << date_of_next('saturday') + 7
      opening_days << date_of_next('saturday') + 14
      opening_days << date_of_next('saturday') + 21
    end
    if self.open_sunday
      opening_days << date_of_next('sunday')
      opening_days << date_of_next('sunday') + 7
      opening_days << date_of_next('sunday') + 14
      opening_days << date_of_next('sunday') + 21
    end
    return opening_days.sort
  end


  def get_opening_hours_string
    hour_string = 'de ' + self.start_time_am.strftime("%I:%M%p").to_s +
                     ' à ' + self.end_time_am.strftime("%I:%M%p").to_s
    if self.start_time_pm.strftime("%I:%M%p")
      afternoon_string = 'de ' + self.start_time_pm.strftime("%I:%M%p").to_s +
                         ' à ' + self.end_time_pm.strftime("%I:%M%p").to_s
      hour_string = hour_string + ' et ' + afternoon_string
    end
    return hour_string
  end

  def update_availability
    disabled_desks = desks.where(activated: false).exists?

    # we have disabled desks but company is still activated
    if disabled_desks == activated
      toggle!(:activated)
    end
  end

  def cheapest_desk
    desks.where(activated: :true).order(daily_price: :asc).first
  end

  private

  def date_of_next(day)
    date  = Date.parse(day)
    delta = date > Date.today ? 0 : 7
    date + delta
  end

  def get_starting_day
    starting_day = []
    if self.open_monday
      start = 'du Lundi'
    elsif self.open_tuesday
      start = 'du Mardi'
    elsif self.open_wednesday
      start = 'du Mercredi'
    elsif self.open_thursday
      start = 'du Jeudi'
    elsif self.open_friday
      start = 'du Vendredi'
    elsif self.open_saturday
      start = 'du Samedi'
    elsif self.open_sunday
      start = 'du Dimanche'
    end
  end

  def get_ending_day
    if self.open_monday == false
      ending = ' au Dimanche'
    elsif self.open_tuesday == false
      ending =' au Lundi'
    elsif self.open_wednesday == false
      ending =' au Mardi'
    elsif self.open_thursday == false
      ending =' au Mercredi'
    elsif self.open_friday == false
      ending =' au Jeudi'
    elsif self.open_saturday == false
      ending =' au Vendredi'
    elsif self.open_sunday == false
      ending =' au Samedi'
    end
  end

  def full_address
    return "#{address},#{postcode},#{city},France"
  end

  def full_address_changed?
    address_changed? || city_changed? || postcode_changed?
  end
end
