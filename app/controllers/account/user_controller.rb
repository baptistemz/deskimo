module Account
  class UserController < Account::Base
    def show
      @user = current_user
      @bookings = @user.bookings
    end
  end
end
