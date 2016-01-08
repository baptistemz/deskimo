module Account
  class BookingsController < Account::Base

    def index
      @user_bookings = current_user.bookings.where(archived: false)
      if current_user.company
        @open_space_bookings = current_user.company.desks.where(kind: :open_space).first.bookings
        @closed_office_bookings = current_user.company.desks.where(kind: :closed_office).first.bookings
        @meeting_room_bookings = current_user.company.desks.where(kind: :meeting_room).first.bookings
      end
    end

    def show
      @booking = current_user.bookings.find(params[:id])
    end

  end
end
