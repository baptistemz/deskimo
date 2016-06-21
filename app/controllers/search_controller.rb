class CompaniesController < ApplicationController

  def index
    # if params[:lat].presence && params[:lng].presence && params[:full_address].presence == false
    #   @location = [params[:lat], params[:lng]]
    # elsif params[:full_address].presence
    #   @location = Geocoder.coordinates(params[:full_address])
    # elsif cookies[:lat_lng]
    #   params[:lat] = cookies[:lat_lng].split(',')[0]
    #   params[:lng] = cookies[:lat_lng].split(',')[1]
    #   @location = cookies[:lat_lng].split(',')
    # else
    #   @location = [Settings.locations.default.latitude, Settings.locations.default.longitude]
    # end
    @location = location
    aggregations = { kinds: { stats: true }}
    # - - - Filters
    # search_conditions = {
    #   activated: true,
    #   location: {
    #     near:   @location,
    #     within: "5km"
    #   }
    # }

    # sort_conditions = [
    #   {
    #     _geo_distance: {
    #       location: {
    #         lat: @location[0],
    #         lon: @location[1]
    #         },
    #       order: "asc",
    #       unit: "km",
    #       mode: "min"
    #     }
    #   }
    # ]



    @companies = Company.search('*', where: search_conditions(@location, params[:kind]), aggs: aggregations, page: params[:page], per_page: thumbnails_per_page, order: sort_conditions(@location))
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

  def search_conditions (location, kind)
    search_conditions = {
      kinds: kind,
      activated: true,
      location: {
        near:   location,
        within: "5km"
      }
    }
  end

  def thumbnails_per_page
    if params[:window_width].to_i < 992
      thumbnails_per_page = 3
    else
      thumbnails_per_page = 6
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
