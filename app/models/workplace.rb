class Workplace < ActiveRecord::Base
  belongs_to :company
  has_many :desks
end
