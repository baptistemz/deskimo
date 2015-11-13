class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :desks, dependent: :destroy

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" , list: "800x400#"}

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  # def search_data
  #   {
  #     description:          description,
  #     desk_description:     company.desks.each{|d| d.description},
  #     name:                 name,
  #     desk_kind:            company.desks.each{|d| d.kind},
  #     coffee:               coffee,
  #     printer:              printer,
  #     scanner:              scanner
  #   }
  # end

  def sort_company_desks_by_hour_price
    self.desks.order(hour_price: :asc)
  end

  private

  def full_address
    return "#{address},#{postcode},#{city},France"
  end

  def full_address_changed?
    address_changed? || city_changed? || postcode_changed?
  end

end
