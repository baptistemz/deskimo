Geocoder.configure(
  lookup:    :google,
  api_key:   ENV['GOOGLE_SERVER_API_KEY'],
  use_https: true,
  units:     :km
)
