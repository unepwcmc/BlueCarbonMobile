(function() {

  window.JST = {};

  window.JST['area/edit'] = _.template("<h3>Work Area #13</h3>\n<input id=\"new-polygon\" type=\"submit\" value=\"Draw a Polygon\"/>");

  window.JST['area/add_polygon'] = _.template("<h3>Work Area #13</h3>\n<form id=\"validation-attributes\" onSubmit=\"return false;\">\n  <ul class=\"fields\">\n    <li>\n      <select name=\"type\">\n        <option value=\"add\">Add</option>\n        <option value=\"delete\">Delete</option>\n      </select>\n    </li>\n  </ul>\n  <input id=\"create-analysis\" type=\"submit\" value=\"Add\">\n</form>");

  window.JST['area/login'] = _.template("<h3>Please login</h3>\n<form id=\"validation-attributes\" onSubmit=\"return false;\">\n  <ul class=\"fields\">\n    <li>\n      <span>Username</span>\n      <input name=\"username\"/>\n    </li>\n    <li>\n      <span>Password</span>\n      <input name=\"Password\" type=\"password\"/>\n    </li>\n  </ul>\n  <input id=\"create-analysis\" type=\"submit\" value=\"Login\">\n</form>");

}).call(this);
