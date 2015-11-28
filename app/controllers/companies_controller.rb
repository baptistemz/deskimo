class CompaniesController < ApplicationController

  def index
    if params[:full_address]
      @location = Geocoder.coordinates(params[:full_address])
    elsif cookies[:lat_lng]
      @location = cookies[:lat_lng].split(',')
    else
      @location = Geocoder.coordinates("Lille")
    end
    @companies = get_displayable_companies(Company.near(@location, 5).where.not(latitude: nil, longitude: nil))
    @companies.each{|company| company.sort_company_desks_by_hour_price}

    @desk = Desk.new
    @kinds = []
    @companies.each{|company| company.desks.each{|desk| @kinds << desk.kind}}
    @kinds.uniq!

    @hash = Gmaps4rails.build_markers(@companies) do |company, marker|
      marker.lat company.latitude
      marker.lng company.longitude
      marker.infowindow render_to_string(partial: "/companies/map_box", locals: { company: company })
    end

    @mypos = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat @location[0].to_f
      marker.lng @location[1].to_f
      marker.picture({
                  :url    => "assets/user_marker.png",
                  :width  => "44",
                  :height => "44"
                 })
      marker.title   "votre position"
    @no_footer = true
    end
  end


end
