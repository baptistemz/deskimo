class UnavailabilityRange < ActiveRecord::Base
  extend Enumerize
  belongs_to :desk

  validates_presence_of :start_date, :end_date, :kind
  validate :start_date_cannot_be_in_the_past
  validate :end_date_must_be_after_start_date
  # validate  :unavailabilities

  enumerize :kind, in: [:booked, :closed], default: :closed

  private

  def unavailabilities

    # errors.add(:start_date, "Bureau indisponible à ces dates") unless
    # UnavailabilityRange.where("? >= start_date AND ? <= end_date", start_date, start_date).count > desk.quantity

    # errors.add(:end_date, "Bureau indisponible à ces dates") unless
    # UnavailabilityRange.where("? >= start_date AND ? <= end_date", end_date, end_date).count > desk.quantity
      # if UnavailabilityRange.where(@range.include?(start_date.to_i) && kind = 'closed' ||
      #                  @range.include?(end_date.to_i) && kind = 'closed')
      #   errors.add(:user, "l'entreprise est fermée sur le/les des jours désirés")

      # elsif Booking.where(@range.include?(start_date.to_i) && kind: :booked ||
      #                  @range.include?(end_date.to_i) && kind: :booked) >= desk.quantity
      #   errors.add(:user, "Plus de bureaux disponibles")
      # end
    # elsif kind = 'closed'
    #   if Booking.where(@range.include?(start_date.to_i) && kind: :booked ||
    #                    @range.include?(end_date.to_i) && kind: :booked)
    #     errors.add(:user, "Il y a déjà des reservations sur cette période. Annulez-les si vous voulez vraiment rendre les bureaux indisponibles.")
    #   end
    # end
  end

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
