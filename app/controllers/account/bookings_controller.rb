module Account
  class BookingsController < Account::Base

    def index

      @user_bookings = current_user.bookings.all
      if current_user.company
        @open_space_bookings = current_user.company.desks.where(kind: :open_space).first.bookings.all
        @closed_office_bookings = current_user.company.desks.where(kind: :closed_office).first.bookings.all
        @meeting_room_bookings = current_user.company.desks.where(kind: :meeting_room).first.bookings.all
      end
    end

  end
end
