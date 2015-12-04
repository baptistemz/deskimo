class CompaniesController < ApplicationController

  skip_before_action :authenticate_user!

  def index

    if params[:full_address].presence
      @location = Geocoder.coordinates(params[:full_address])
    elsif cookies[:lat_lng]
      @location = cookies[:lat_lng].split(',')
    else
      @location = Geocoder.coordinates("Lille")
    end

    @available_companies = Company.where(activated: true)
    @companies = @available_companies.near(@location, 5).where.not(latitude: nil, longitude: nil)

    if params[:kind].present?
      @companies = @companies.joins(:desks).where(desks: { kind: params[:kind] })

      if @companies.empty?
        flash[:notice] = "Aucun bureau n'est disponible avec le type sélectionné !"
        redirect_to companies_path
      end
    end

    @kinds = Desk.where(company: @available_companies.pluck(:id)).pluck(:kind)

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
