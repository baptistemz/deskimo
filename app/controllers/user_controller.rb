Class UserController < ApplicationController

  def update
    @company = Company.find(params[:company])
    @desk = Desk.find(params[:desk])
    @booking = Booking.find(params[:booking])
    @user = current_user
    if current_user.update(user_params)
      redirect_to new_company_desk_booking_payment(@company, @desk, @booking)
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
