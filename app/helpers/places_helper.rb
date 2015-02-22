module PlacesHelper

  def map_url_for(place)
    if mobile_device?
      "comgooglemaps://?center=#{place.latitude},#{place.longitude}&zoom=15"
    else
      "https://www.google.com/maps/@#{place.latitude},#{place.longitude},15z"
    end

  end
end
