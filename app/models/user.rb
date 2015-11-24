class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :bookings
  has_one :company, :dependent => :destroy

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

  # def self.find_for_google_oauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]  # Fake password for validation
  #     user.first_name = auth.info.first_name
  #     user.last_name = auth.info.last_name
  #     user.picture = auth.info.image
  #     user.token = auth.credentials.token
  #     user.token_expiry = Time.at(auth.credentials.expires_at)
  #   end
  # end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    raise
    unless user
        user = User.create(first_name: data["first_name"],
          last_name: data["last_name"],
          email: data["email"],
          password: Devise.friendly_token[0,20]
        )
    end
    user
end
end
