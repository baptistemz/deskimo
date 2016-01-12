class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.desk = Desk.find(params[:desk_id])
    @next_available_days = @booking.desk.get_next_available_days_array

    if @booking.time_slot_type == "half_day"
      @booking.end_date = @booking.start_date
      @booking.amount = @booking.desk.half_day_price
    elsif @booking.time_slot_type == "day(s)"
      booking_day_number = @next_available_days.find_index(@booking.start_date)
      @booking.end_date = @next_available_days[booking_day_number + @booking.time_slot_quantity - 1]
      @booking.amount = @booking.desk.daily_price * @booking.time_slot_quantity
    else
      @booking.end_date = @booking.start_date + (7 * @booking.time_slot_quantity).days
      @booking.amount = @booking.desk.weekly_price * @booking.time_slot_quantity
    end
    if @booking.save
      @unavailability = @booking.build_unavailability_range(
                                            desk: @booking.desk,
                                            kind: :booked,
                                            start_date: @booking.start_date,
                                            end_date: @booking.end_date
                                            )
      if @unavailability.save
        CleanUnpaidBookingsJob.set(wait: 2.minutes).perform_later(@booking.id)
        redirect_to company_desk_booking_confirmation_path(@booking.desk.company, @booking.desk, @booking )
      else
        flash[:alert] = "Bureau indisponible à ces dates"
        redirect_to(:back)
      end
    else
      flash[:alert] = 'Reservation impossible'
      redirect_to(:back)
    end
  end

  def confirmation
    @booking = current_user.bookings.find(params[:booking_id])
    @user = current_user
  end

  private

  def booking_params
    params.require(:booking).permit(:time_slot_quantity,
                                    :time_slot_type,
                                    :start_date,
                                    :half_day_choice)
  end
end
