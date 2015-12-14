class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_locale

  # include Pundit

  # after_action :verify_authorized, except: :index, unless: :devise_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end
  def set_locale
    if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
      l = cookies[:educator_locale].to_sym
    else
      l = I18n.default_locale
      cookies.permanent[:educator_locale] = l
    end
    I18n.locale = l
  end

  def lat_lng
    @lat_lng ||= session[:lat_lng] ||= get_geolocation_data_the_hard_way
  end

  def default_url_options

    if Rails.env.production?
      { host: 'nomadoffice.herokuapp.com' }
    else
      { host: ENV['HOST'] || 'localhost:3000' }
    end
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

end
