class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
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
