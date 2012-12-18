L.Control.Gps = L.Control.extend(
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
    navigator.geolocation.getCurrentPosition( (position)=>
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

    console.log('render')
)
