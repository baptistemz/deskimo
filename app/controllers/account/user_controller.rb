module Account
  class UserController < Account::Base
    def show
      @user = current_user
      @bookings = @user.bookings
      @company = @user.company
    end

    def edit
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update(user_params)
        if params[:booking]
          if @user.bookings.find(params[:booking]).update(status: :identified)
            redirect_to new_booking_payment_path(params[:booking])
          else
            redirect_to :back
          end
        else
          redirect_to account_user_path
        end
      else
        render :edit
        return
      end
    end

    def archived_bookings
      @bookings = current_user.bookings.where(archived: true)
    end

    private

    def user_params
      params.require(:user).permit( :first_name,
                                    :last_name,
                                    :avatar,
                                    :calendar_access_token,
                                    :calendar_refresh_token )
    end
  end
end
