module Account
  class BookingsController < Account::Base

    def index
      @user_bookings = current_user.bookings.where(archived: false)
      if current_user.company
        @open_space = current_user.company.desks.where(kind: :open_space).first
        @closed_office = current_user.company.desks.where(kind: :closed_office).first
        @meeting_room = current_user.company.desks.where(kind: :meeting_room).first
        if @open_space && @open_space.bookings.any?
          @open_space_bookings = @open_pace.bookings
        end
        if @closed_office && @closed_office.bookings.any?
          @closed_office_bookings = @closed_office.bookings
        end
        if @meeting_room && @meeting_room.bookings.any?
          @meeting_room_bookings = @meeting_room.bookings
        end
      end
    end

    def show
      @booking = current_user.bookings.find(params[:id])
    end

  end
end
