module Account
  class BookingsController < Account::Base

    def index
      @user_bookings = current_user.bookings.where(archived: false)
      if current_user.company
        @open_space = current_user.company.desks.where(kind: :open_space).first
        @closed_office = current_user.company.desks.where(kind: :closed_office).first
        @meeting_room = current_user.company.desks.where(kind: :meeting_room).first
        if @open_space
          @open_space_bookings = @open_space.bookings.where(archived: false)
        end
        if @closed_office
          @closed_office_bookings = @closed_office.bookings.where(archived: false)
        end
        if @meeting_room
          @meeting_room_bookings = @meeting_room.bookings.where(archived: false)
        end
      end
    end

    def show
      @booking = current_user.bookings.find(params[:id])
      @desk = @booking.desk
      @company = @booking.desk.company
    end

  end
end
