class CompaniesController < ApplicationController

  def index
    @company = Company.new
    @position = Geocoder.coordinates(params[:full_address])
    @companies = Company.near(@position, 5)
    @companies.each{|company| company.sort_company_desks_by_hour_price}
  end

  def show
    @company = Company.find(params[:id])
  end


end
