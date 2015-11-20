class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def lat_lng
    @lat_lng ||= session[:lat_lng] ||= get_geolocation_data_the_hard_way
  end

  # def after_sign_up_path_for(resource)
  #   redirect_to new_company_path(resource)
  # end
  # def authenticate!
  #  :authenticate_user! || :authenticate_florist!
  #  @current_user = user_signed_in? ? current_user : current_florist
  # end
end
