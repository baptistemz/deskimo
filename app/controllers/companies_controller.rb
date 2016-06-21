class CompaniesController < ApplicationController

  def index
    @location = location
    aggregations = { kinds: { stats: true }}
    search_conditions = search_conditions(@location)
    search_conditions[:kinds] = params[:kind] if params[:kind].present?
    @companies = Company.search('*', where: search_conditions,
                                     aggs: aggregations,
                                     page: params[:page],
                                     per_page: 6,
                                     order: sort_conditions(@location))
    @kinds = @companies.aggs["kinds"]["buckets"].map { |facet| facet["key"] }
    build_map
    @no_footer = true
  end

  private

  def location
    if params[:lat].presence && params[:lng].presence && params[:full_address].presence == false
      @location = [params[:lat], params[:lng]]
    elsif params[:full_address].presence
      @location = Geocoder.coordinates(params[:full_address])
    elsif cookies[:lat_lng]
      params[:lat] = cookies[:lat_lng].split(',')[0]
      params[:lng] = cookies[:lat_lng].split(',')[1]
      @location = cookies[:lat_lng].split(',')
    else
      @location = [Settings.locations.default.latitude, Settings.locations.default.longitude]
    end
  end

  def sort_conditions (location)
    sort_conditions = [
      {
        _geo_distance: {
          location: {
            lat: location[0],
            lon: location[1]
            },
          order: "asc",
          unit: "km",
          mode: "min"
        }
      }
    ]
  end

  def search_conditions (location)
    search_conditions = {
      activated: true,
      location: {
        near:   location,
        within: "5km"
      }
    }
  end

  def build_map
    @hash = Gmaps4rails.build_markers(@companies) do |company, marker|
      marker.lat company.latitude
      marker.lng company.longitude
      marker.infowindow render_to_string(partial: "/companies/map_box", locals: { company: company })
    end

    @mypos = Gmaps4rails.build_markers(@location) do |location, marker|
      marker.lat @location[0]
      marker.lng @location[1]
      marker.picture(
        url:    "/assets/user_marker.svg",
        width:  30,
        height: 44
      )
      marker.title   "votre position"
    end
  end
end
