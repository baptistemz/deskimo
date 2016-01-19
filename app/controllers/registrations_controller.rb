class RegistrationsController < Devise::RegistrationsController
  protected

  # def sign_up_params
  #   if params[:user_type] == "company"
  #     params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  #   else
  #     params.require(:user).permit( :email, :password, :password_confirmation)
  #   end
  # end

  def after_sign_up_path_for(resource)
    if params[:user_type] == "company"
      new_account_company_path
    elsif session[:previous_url]
      session[:previous_url]
    else
      '/'
    end
  end
end
