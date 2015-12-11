class SessionsionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if session[:previous_url]
      session[:previous_url]
    else
      '/'
    end
  end
end
