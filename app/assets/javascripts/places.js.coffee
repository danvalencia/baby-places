# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Map

  constructor:(@element = "map-canvas") ->
    @markers = []
    @zoomLevel = 16

  initializeMap:(center) ->
    if center
      showMapInCoordinates(center)
    else if navigator.geolocation
      navigator.geolocation.getCurrentPosition(@.onLocationRetrieved)

  onLocationRetrieved:(position) =>
    currentLocation = {lat: position.coords.latitude, lng: position.coords.longitude}
    @.showMapInCoordinates(currentLocation)

  showMapInCoordinates:(coordinates) ->
    mapOptions = 
      center: coordinates
      zoom: @zoomLevel
    @map = new google.maps.Map(document.getElementById(@element),mapOptions)
    @.setupSearchField()
    @.setMarkerOnCoordinates(coordinates)

  setupSearchField: ->
    input = document.getElementById 'pac-input'
    @map.controls[google.maps.ControlPosition.TOP_LEFT].push input 
    @searchBox = new google.maps.places.SearchBox(input)
    google.maps.event.addListener(@searchBox, 'places_changed', @.onPlaceSelection)

  onPlaceSelection: =>
    @map.initialZoom = true

    google.maps.event.addListener @map, 'zoom_changed', () =>
      google.maps.event.addListenerOnce @map, 'bounds_changed', (event) =>
        if @map.getZoom() > @zoomLevel and @map.initialZoom == true
          @map.setZoom(@zoomLevel)
          @map.initialZoom = false

    console.log "Place selected! #{@searchBox}"
    places = @searchBox.getPlaces()
    return if places.length == 0

    for marker in @markers
      marker.setMap(null)

    @markers = []

    bounds = new google.maps.LatLngBounds()

    for place in places
      marker = new google.maps.Marker
        map: @map
        title: place.name
        position: place.geometry.location

      @markers.push marker
      bounds.extend(place.geometry.location)

    @map.fitBounds bounds

  setMarkerOnCoordinates:(coordinates) =>
    marker = new google.maps.Marker
      map:@map
      draggable: true
      animation: google.maps.Animation.DROP
      position: coordinates

    @markers.push marker

    @.updateCoordinateFormFields coordinates
    google.maps.event.addListener(marker, 'dragend', @.onMarkerDrop)

  onMarkerDrop: (mouseEvent) =>
    console.log "Marker position is now (#{mouseEvent.latLng.lat()},#{mouseEvent.latLng.lng()})"
    @.updateCoordinateFormFields {lat: mouseEvent.latLng.lat(), lng: mouseEvent.latLng.lng()}

  updateCoordinateFormFields:(coordinates) ->
    $("#place_latitude").val(coordinates.lat)
    $("#place_longitude").val(coordinates.lng)


window.Map = new Map