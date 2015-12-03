class BookingsController < ApplicationController
  def create
    @booking = current_user.bookings.build(booking_params)
    @booking.desk = Desk.find(params[:desk_id])
    @next_opening_days = @booking.desk.company.get_next_opening_days_array

    @opening_hours = []
    @opening_hours_string_splited = @booking.desk.company.get_opening_hours_string.split(' ')
    @opening_hours = [@opening_hours_string_splited[1], @opening_hours_string_splited[3], @opening_hours_string_splited[6], @opening_hours_string_splited[8]]
    @morning_hours = (@opening_hours[1].to_time - @opening_hours[0].to_time)/60/60

    if @booking.time_slot_type == "heure(s)"

      if @morning_hours > @booking.time_slot_quantity
        @booking.end_date_time = @booking.start_date_time + @booking.time_slot_quantity.hours
      else
        monring_hours = (@opening_hours[1].to_time - @opening_hours[0].to_time)/60/60
        @booking.end_date_time = @opening_hours[2].to_time + @booking.time_slot_quantity.hours - @morning_hours
      end

    elsif time_slot_type == "jour(s)"
      @booking.end_date_time = @booking.start_date_time + @booking.time_slot_quantity.days
    else time_slot_type
      @booking.end_date_time = @booking.start_date_time + @booking.time_slot_quantity.week.to_i
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:time_slot_quantity,
                                    :time_slot_type,
                                    :start_date_time)
  end
end
