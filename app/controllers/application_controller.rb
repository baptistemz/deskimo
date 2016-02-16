class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  after_filter :store_location

  # http_basic_authenticate_with name: [ENV['MY_SITE_USERNAME'], password: ENV['MY_SITE_SECRET']] if Rails.env == 'staging'


  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def lat_lng
    @lat_lng ||= session[:lat_lng]
  end

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  private

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def set_locale
    if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
      l = cookies[:educator_locale].to_sym
    else
      l = I18n.default_locale
      cookies.permanent[:educator_locale] = l
    end
    I18n.locale = l
  end
end
