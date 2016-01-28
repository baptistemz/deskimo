class RegistrationsController < Devise::RegistrationsController

  protected

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
