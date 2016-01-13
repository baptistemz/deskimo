class Invoice < ActiveRecord::Base
  belongs_to :booking
end
