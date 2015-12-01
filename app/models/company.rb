class Company < ActiveRecord::Base

  has_many :desks, dependent: :destroy
  belongs_to :user

  has_attached_file :picture,
    styles: { large: "500x500", medium: "300x300>", thumb: "100x100>" , list: "800x400#"}
    # rake paperclip:refresh CLASS=Company

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  validates_presence_of :name, :siret, :address, :city, :description

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

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

  def sort_company_desks_by_hour_price
    self.desks.where(activated: :true).order(hour_price: :asc)
  end

  private

  def get_starting_day
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
