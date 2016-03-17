class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :bookings, dependent: :nullify
  has_one :credit_card, dependent: :destroy
  has_one :company, :dependent => :nullify
  has_many :inbound_payments, class_name: 'Payment', foreign_key: :receiver_id
  has_many :outbound_payments, class_name: 'Payment', foreign_key: :payer_id
  validates_presence_of :first_name, :last_name, :on => :update
  has_attached_file :avatar,
    styles: {avatar: "150x150#"}
    # rake paperclip:refresh CLASS=User
  validates_attachment_content_type :avatar,
    content_type: /\Aimage\/.*\z/

  after_create :send_welcome_email


  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
          first_name: data["first_name"],
          last_name: data["last_name"],
          picture: data["image"],
          email: data["email"],
          password: Devise.friendly_token[0,20]
        )
    end
    user
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end



  # def update_mangopay_profile
  #   params = {
  #     "Email" => self.email,
  #     "FirstName" => self.first_name,
  #     "LastName" => self.last_name,
  #     "Birthday" => 467909843,
  #     "Nationality" => "FR",
  #     "CountryOfResidence" => "FR"
  #   }
  #   begin
  #     if self.mangopay_user_id
  #       response = MangoPay::NaturalUser.update(self.mangopay_user_id, params)
  #     else
  #       response = MangoPay::NaturalUser.create(params)
  #     end
  #   rescue MangoPay::ResponseError => e
  #     puts e
  #   end
  #   self.mangopay_user_id = response["Id"]
  #   self.save
  # end


  # def create_or_update_wallet
  #   self.update_mangopay_profile
  #   params = {
  #     "Owners" => ["#{self.mangopay_user_id}"],
  #     "Description" => "deskimo Wallet #{self.email}",
  #     "Currency" => "EUR"
  #   }

  #   begin
  #     if self.mangopay_wallet_id
  #       response = MangoPay::Wallet.update(self.mangopay_wallet_id, params)
  #     else
  #       response = MangoPay::Wallet.create(params)
  #     end
  #   rescue MangoPay::ResponseError => e
  #     puts e
  #   end
  #   self.mangopay_wallet_id = response["Id"]
  #   self.save
  # end

end
