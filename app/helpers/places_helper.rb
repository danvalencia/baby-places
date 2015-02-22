module PlacesHelper

  def map_url_for(place)
    if mobile_device?
      "comgooglemaps://?center=#{place.latitude},#{place.longitude}&q=#{place.latitude},#{place.longitude}&zoom=15"
    else
      "https://www.google.com/maps?z=15&q=#{place.latitude}+#{place.longitude}&ll=#{place.latitude}+#{place.longitude}"
    end

  end
end
