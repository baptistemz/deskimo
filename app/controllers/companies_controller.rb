class CompaniesController < ApplicationController

  def index

    @location = Geocoder.coordinates(params[:full_address])
    @companies = Company.near(@location, 10)
    @companies.each{|company| company.sort_company_desks_by_hour_price}

    @hash = Gmaps4rails.build_markers(@companies) do |company, marker|
      marker.lat company.latitude
      marker.lng company.longitude
      marker.infowindow render_to_string(partial: "/companies/map_box", locals: { company: company })
    end
  end

  def show
    @company = Company.find(params[:id])
  end


end
