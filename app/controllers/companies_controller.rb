class CompaniesController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    if params[:full_address]
      @location = Geocoder.coordinates(params[:full_address])
    elsif cookies[:lat_lng]
      @location = cookies[:lat_lng].split(',')
    else
      @location = Geocoder.coordinates("Lille")
    end

    @companies = get_displayable_companies(Company.near(@location, 5).where.not(latitude: nil, longitude: nil))
    @companies.each{|company| company.sort_company_desks_by_daily_price}

    @desk = Desk.new
    @kinds = {open_space: "open space", closed_office: 'bureau fermé', meeting_room: 'salle de réunion'}

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
    end
    @no_footer = true
  end


end
