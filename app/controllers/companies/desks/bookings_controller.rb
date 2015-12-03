module Companies
  module Desks
    class BookingsController
      def create
        @booking = desk.build_booking(booking_params)
        @booking.user = User.find(params[:user_id])
        if @booking.time_slot_type == "heure(s)"
          @booking.end_date_time = @booking.start_date_time + @booking.time_slot_quantity.hours
          raise
        elsif time_slot_type == "jour(s)"
          @booking.end_date_time = @booking.start_date_time + @booking.time_slot_quantity.days
          raise
        else time_slot_type
          @booking.end_date_time = @booking.start_date_time + @booking.time_slot_quantity.week.to_i
          raise
      end

      private

      def booking_params
        params.require(:booking).permit(:time_slot_quantity,
                                        :time_slot_type,
                                        :start_date_time)
      end
    end
  end
end
