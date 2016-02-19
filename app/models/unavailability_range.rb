class UnavailabilityRange < ActiveRecord::Base
  extend Enumerize
  belongs_to :desk
  belongs_to :booking

  validates_presence_of :start_date, :end_date, :kind
  validate :start_date_cannot_be_in_the_past
  validate :end_date_must_be_after_start_date

  enumerize :kind, in: [:booked, :closed, :planned], default: :closed

  private

  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, 'Hep! On ne gère pas les disponibilités du passé ;)')
    end
  end

  def end_date_must_be_after_start_date
    if end_date < start_date
      errors.add(:start_date, 'La date de fin doit être postérieure à celle du début')
    end
  end

end
