class CompaniesController < ApplicationController

  def index
    # elsif params[:lat] && params[:lng]
    #   @location = [params[:lat], params[:lng]]
    if params[:full_address].presence
      @location = Geocoder.coordinates(params[:full_address])
    elsif cookies[:lat_lng]
      @location = cookies[:lat_lng].split(',')
    else
      @location = [Settings.locations.default.latitude, Settings.locations.default.longitude]
    end

    aggregations = { kinds: { stats: true }}

    # - - - Filters
    search_conditions = {
      activated: true,
      location: {
        near:   @location,
        within: "5km"
      }
    }

    if params[:kind].present?
      @kind                     = params[:kind]
      search_conditions[:kinds] = @kind
    end

    @companies = Company.search('*', where: search_conditions, aggs: aggregations)

    if @companies.empty?
      flash[:notice] = "Aucun bureau ne correspond à votre recherche !"
    end

    @kinds = @companies.aggs["kinds"]["buckets"].map { |facet| facet["key"] }

    @hash = Gmaps4rails.build_markers(@companies) do |company, marker|
      marker.lat company.latitude
      marker.lng company.longitude
      marker.infowindow render_to_string(partial: "/companies/map_box", locals: { company: company })
    end

    @mypos = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat @location[0].to_f
      marker.lng @location[1].to_f

      marker.picture(
        url:    "assets/user_marker.png",
        width:  "44",
        height: "44"
      )

      marker.title   "votre position"
    end

    @no_footer = true
  end
end
