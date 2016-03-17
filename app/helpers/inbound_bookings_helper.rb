module InboundBookingsHelper
  def new_inbound_bookings
    if current_user.company
      @desks = current_user.company.desks.all
      return @desks.joins(:bookings).where(bookings: { status: 'paid' }).any?
    end
  end
end
