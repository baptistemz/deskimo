class CompaniesController < ApplicationController

  def index
    if params[:full_address]
      @location = Geocoder.coordinates(params[:full_address])
    else
      @location = cookies[:lat_lng].split(',')
    end
    @companies = Company.near(@location, 5)
    @companies.each{|company| company.sort_company_desks_by_hour_price}
    geo_companies = @companies.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(geo_companies) do |company, marker|
      marker.lat company.latitude
      marker.lng company.longitude
      marker.infowindow render_to_string(partial: "/companies/map_box", locals: { company: company })
    end
  end

  def show
    @companies = Company.all
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end


end
