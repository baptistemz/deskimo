class ClosingDay < ActiveRecord::Base
  belongs_to :company
  validates_uniqueness_of :date, scope: :company_id
end
