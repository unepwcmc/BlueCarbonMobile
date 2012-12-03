(function() {

  window.JST = {};

  window.JST['area/edit'] = _.template("<h3>Work Area #13</h3>\n<input id=\"new-polygon\" type=\"submit\" value=\"Draw a Polygon\"/>");

  window.JST['area/add_polygon'] = _.template("<h3>Work Area #13</h3>\n<form id=\"polygon-attributes\">\n  <ul class=\"fields\">\n    <li>\n      <select>\n        <option value=\"add\">Add</option>\n        <option value=\"delete\">Delete</option>\n      </select>\n    </li>\n  </ul>\n  <input id=\"create-polygon\" type=\"submit\" value=\"Add\">\n</form>");

}).call(this);
