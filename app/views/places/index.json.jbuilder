json.array!(@places) do |place|
  json.extract! place, :id, :name, :amenities, :latitude, :longitude, :address
  json.url place_url(place, format: :json)
end
