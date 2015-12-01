module Companies
  module Desks
    class BookingsController
      def create
        @booking = desk.build_booking(booking_params)
        @booking.company = desk.company
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
