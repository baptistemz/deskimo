class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def lat_lng
    @lat_lng ||= session[:lat_lng] ||= get_geolocation_data_the_hard_way
  end

  def get_displayable_companies(companies)
    @companies = []
    companies.each do |company|
      if company.desks.where(activated:true).length >0
        @companies << company
      end
    end
    return @companies
  end
end
