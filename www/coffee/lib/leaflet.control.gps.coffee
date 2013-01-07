L.Control.ShowLocation = L.Control.extend(
  options:
    position: 'topright'
    text: ''
    iconUrl: 'css/images/location_finder.png'

  onAdd: (map) ->
    @showLocation = false
    @container = L.DomUtil.create('div', 'my-custom-control')
    @render()

    @map = map

    return @container

  onClick: (e) ->
    @showLocation = !@showLocation
    if @showLocation
      @startTracking()
    else
      @stopTracking()

  drawLocation: (position) ->
    if @marker?
      @map.removeLayer(@marker)

    GpsIcon = L.Icon.extend(
      options:
        iconUrl: 'css/images/gps-marker.png'
        iconSize: [16, 16]
    )

    gpsIcon = new GpsIcon()

    latlng = [
      position.coords.latitude,
      position.coords.longitude
    ]

    @marker = L.marker(latlng, {icon: gpsIcon}).addTo(@map)

    @marker.on('click', (=> @onClick()))

  updateMarker: ->
    navigator.geolocation.getCurrentPosition(((position)=> @drawLocation(position)), (->
      console.log("unable to get current location: ")
      console.log arguments
    ), {enableHighAccuracy: true})

  startTracking: () ->
    unless @geoWatchId?
      @updateMarker()
      @geoWatchId = setInterval((=> @updateMarker()), 30000)

  stopTracking: () ->
    if @geoWatchId?
      clearInterval(@geoWatchId)
      @geoWatchId = null

    if @marker?
      @map.removeLayer(@marker)

  render: () ->
    button = L.DomUtil.create('div', 'leaflet-buttons-control-button', @container)

    image = L.DomUtil.create('img', 'leaflet-buttons-control-img', button)
    image.setAttribute('src', @options.iconUrl)

    if @options.text != ''
      span = L.DomUtil.create('span', 'leaflet-buttons-control-text', button)
      text = document.createTextNode(@options.text)
      span.appendChild(text)

    L.DomEvent
      .addListener(button, 'click', L.DomEvent.stop)
      .addListener(button, 'touchstart', @onClick, this)

    L.DomEvent.disableClickPropagation(button)
)

L.Control.JumpToLocation = L.Control.extend(
  options:
    position: 'topright'
    text: ''
    iconUrl: 'css/images/location_finder.png'

  onAdd: (map) ->
    @container = L.DomUtil.create('div', 'my-custom-control')
    @render()

    @map = map

    return @container

  onClick: (e) ->
    navigator.geolocation.getCurrentPosition((position)=>
      @moveCenter(position)
    , {}, {enableHighAccuracy: true})


  moveCenter: (position) ->
    latlng = [
      position.coords.latitude,
      position.coords.longitude
    ]
    @map.panTo(latlng)

  render: () ->
    button = L.DomUtil.create('div', 'leaflet-buttons-control-button', @container)

    image = L.DomUtil.create('img', 'leaflet-buttons-control-img', button)
    image.setAttribute('src', @options.iconUrl)

    if @options.text != ''
      span = L.DomUtil.create('span', 'leaflet-buttons-control-text', button)
      text = document.createTextNode(@options.text)
      span.appendChild(text)

    L.DomEvent
      .addListener(button, 'click', L.DomEvent.stop)
      .addListener(button, 'touchstart', @onClick, this)

    L.DomEvent.disableClickPropagation(button)
)
