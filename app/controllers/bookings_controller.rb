class BookingsController < ApplicationController

  before_action :authenticate_user!

  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.desk = Desk.find(params[:desk_id])
    @next_opening_days = @booking.desk.company.get_next_opening_days_array

    if @booking.time_slot_type == "1/2 journée"
      @booking.end_date = @booking.start_date
    elsif @booking.time_slot_type == "jour(s)"
      booking_day_number = @next_opening_days.find_index(@booking.start_date)
      @booking.end_date = @next_opening_days[booking_day_number + @booking.time_slot_quantity - 1]
    else
      @booking.end_date = @booking.start_date + (7 * @booking.time_slot_quantity).days
    end

    @unavailability = @booking.desk.unavailability_ranges.build(
                                                kind: :booked,
                                                start_date: @booking.start_date,
                                                end_date: @booking.end_date
                                                )
    if @unavailability.save
      if @booking.save
        raise
        redirect_to
        # ???
      else
        flash[:error]
        raise
        redirect_to(:back)
      end
    else
      flash[:alert] = "Le bureau n'est pas disponible sur ces dates"
      redirect_to(:back)
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:time_slot_quantity,
                                    :time_slot_type,
                                    :start_date,
                                    :half_day_choice)
  end
end
