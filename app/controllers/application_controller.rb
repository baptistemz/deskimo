class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  after_filter :store_location
  before_filter :staging_authenticate

  # include Pundit

  # after_action :verify_authorized, except: :index, unless: :authorized_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :authorized_controller?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


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

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  # def authorized_controller?
  #   devise_controller? ||
  #   params[:controller] = "high_voltage/pages" ||
  #   companies_controller? ||
  #   desks_controller?
  # end

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

  def staging_authenticate
    if Rails.env == 'staging'
      authenticate_or_request_with_http_basic 'Staging' do |name, password|
        name == ENV['MY_SITE_USERNAME'] && password == ENV['MY_SITE_SECRET']
      end
    end
  end
end
