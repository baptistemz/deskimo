class CompaniesController < ApplicationController

  def index
    if params[:full_address]
      @location = Geocoder.coordinates(params[:full_address])
    elsif cookies[:lat_lng]
      @location = cookies[:lat_lng].split(',')
    else
      @location = Geocoder.coordinates("Lille")
    end
    @desk = Desk.new
    get_displayable_companies(Company.near(@location, 5))

    @companies.each{|company| company.sort_company_desks_by_hour_price}
    # geo_companies = @companies.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@companies) do |company, marker|
      marker.lat company.latitude
      marker.lng company.longitude
      marker.infowindow render_to_string(partial: "/companies/map_box", locals: { company: company })
    end
  end

  def show
    @companies = Company.all
    @company = Company.find(params[:id])
  end
end
