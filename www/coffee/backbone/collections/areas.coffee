window.BlueCarbon ||= {}
window.BlueCarbon.Collections ||= {}

class BlueCarbon.Collections.Areas extends Backbone.Collection
  model: BlueCarbon.Models.Area
  
  url: 'http://bluecarbon.unep-wcmc.org/areas.json'
