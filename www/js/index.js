var app = {
  // Application Constructor
  initialize: function() {
    this.bindEvents();
  },
  // Bind Event Listeners
  //
  // Bind any events that are required on startup. Common events are:
  // 'load', 'deviceready', 'offline', and 'online'.
  bindEvents: function() {
    document.addEventListener('deviceready', this.onDeviceReady, false);
  },
  // deviceready Event Handler
  //
  // The scope of 'this' is the event. In order to call the 'receivedEvent'
  // function, we must explicity call 'app.receivedEvent(...);'
  onDeviceReady: function() {
   // create a map in the "map" div, set the view to a given place and zoom
    var map = L.map('map').setView([51.505, -0.09], 13);

    // add a CloudMade tile layer with style #997
    L.tileLayer('http://{s}.tile.cloudmade.com/[API-key]/997/256/{z}/{x}/{y}.png', {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
        }).addTo(map);

    // add a marker in the given location, attach some popup content to it and open the popup
    L.marker([51.5, -0.09]).addTo(map)
      .bindPopup('A pretty CSS3 popup. <br> Easily customizable.').openPopup(); 
  }
};
