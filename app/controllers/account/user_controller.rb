module Account
  class UserController < Account::Base
    def show
      @user = current_user
      @bookings = @user.bookings
    end

    def edit
    end
    def update
      @user = current_user
      if current_user.update(user_params)
        redirect_to
        #???
      else
        render :back
      end
    end

    private

    def user_params
      params.require(:user).permit( :first_name,
                                    :last_name,
                                    :email)
    end
  end
end
