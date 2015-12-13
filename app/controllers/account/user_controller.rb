module Account
  class UserController < Account::Base
    def show
      @user = current_user
      @bookings = @user.bookings
    end

    def edit
      @user = current_user
    end

    def update
      @user = current_user
      if current_user.update(user_params)
        if params[:next_step] == 'payment'
          render :back
        else
          redirect_to account_user_path
        end
      else
        redirect_to :back
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
