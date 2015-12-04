class BookingsController < ApplicationController
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

    if @booking.save
      raise
      redirect_to
      # I DON'T KNOW
    else
      flash[:alert] = "La reservation n'a pas pu être effectuée"
      redirect_to(:back)
      # ???
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
