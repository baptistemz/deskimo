json.extract! company, :name, :coffee, :printer, :wifi
json.picture company.picture.url

json.distance number_with_precision(company.distance_from(@location), precision: 1)
if kind == "closed_office"
  json.price cheapest_daily_price(company.desks.where(kind: "closed_office"))
elsif kind == "open_space"
  json.price cheapest_daily_price(company.desks.where(kind: "open_space"))
elsif kind == "meeting_room"
  json.price cheapest_daily_price(company.desks.where(kind: "meeting_room"))
else
  json.price company.cheapest_desk_price
end
