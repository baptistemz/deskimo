class RegistrationsController < Devise::RegistrationsController
  protected

  # def sign_up_params
  #   if params[:user_type] == "company"
  #     params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  #   else
  #     params.require(:user).permit( :email, :password, :password_confirmation)
  #   end
  # end
  def after_update_path_for(resource)
    # if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
    #   user_params = params[:user]
    #   current_user.update(email: user_params[:email], first_name: user_params[:first_name], last_name: user_params[:last_name])
    # end
    user_params = params[:user]
    resource.update(first_name: user_params[:first_name], last_name: user_params[:last_name])
    account_user_path
  end

  def after_sign_up_path_for(resource)
    if params[:user_type] == "company"
      new_account_company_path
    elsif session[:previous_url]
      UserMailer.welcome(params[:user]).deliver_later
      session[:previous_url]
    else
      '/'
    end
  end
end
