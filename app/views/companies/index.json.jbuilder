json.companies do
  json.array! @companies do |company|
    json.partial! "companies/company", company: company, location: @location, kind: params[:kind]
  end
end
