# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Map

  constructor:(@element = "map-canvas") ->

  initializeMap:(center) ->
    if center
      showMapInCoordinates(center)
    else if navigator.geolocation
      navigator.geolocation.getCurrentPosition(@.onLocationRetrieved)

  onLocationRetrieved:(position) =>
    currentLocation = {lat: position.coords.latitude, lng: position.coords.longitude}
    console.log "Center is: #{currentLocation}"
    @.showMapInCoordinates(currentLocation)

  showMapInCoordinates:(coordinates) ->
    mapOptions = 
      center: coordinates
      zoom: 16
    @map = new google.maps.Map(document.getElementById(@element),mapOptions);
    @.setMarkerOnCoordinates(coordinates)

  setMarkerOnCoordinates:(coordinates) =>
    marker = new google.maps.Marker
      map:@map
      draggable: true
      animation: google.maps.Animation.DROP
      position: coordinates
    @.updateCoordinateFormFields coordinates
    google.maps.event.addListener(marker, 'dragend', @.onMarkerDrop)

  onMarkerDrop: (mouseEvent) =>
    console.log "Marker position is now (#{mouseEvent.latLng.lat()},#{mouseEvent.latLng.lng()})"
    @.updateCoordinateFormFields {lat: mouseEvent.latLng.lat(), lng: mouseEvent.latLng.lng()}

  updateCoordinateFormFields:(coordinates) ->
    $("#place_latitude").val(coordinates.lat)
    $("#place_longitude").val(coordinates.lng)


window.Map = new Map