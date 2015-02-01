# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Map

  constructor:(@element = "map-canvas") ->

  initializeMap:(center) ->
    console.log "Inside initializeMap!"
    
    if center
      showMapInCenter(center)
    else 
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition(@.onLocationRetrieved)

  onLocationRetrieved:(position) =>
    coordinates = {lat: position.coords.latitude, lng: position.coords.longitude}
    console.log "Center is: #{coordinates}"
    @.showMapInCoordinates(coordinates)

  showMapInCoordinates:(coordinates) ->
    mapOptions = 
      center: coordinates
      zoom: 16
    map = new google.maps.Map(document.getElementById(@element),mapOptions);

window.Map = new Map