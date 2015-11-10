class Booking < ActiveRecord::Base
  belongs_to :desk
  belongs_to :user
end
