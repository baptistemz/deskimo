module Account
  class BookingsController < Account::Base

    def index
      @user_bookings = current_user.bookings.where(archived: false)
      if current_user.company
        @desks = current_user.company.desks
      end
    end

    def show
      @booking = current_user.bookings.find(params[:id])
      @desk = @booking.desk
      @company = @booking.desk.company
    end

    # def confirmation
      # @company = current_user.company
      # @desk = @company.desks.find(params[:desk_id])
      # @booking = @desk.bookings.find(params[:booking_id])
      # @user = @booking.user
    # end
  end
end
