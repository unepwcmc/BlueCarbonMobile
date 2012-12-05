(function() {

  window.JST = {};

  window.JST['area/edit'] = _.template("<h3>Work Area #13</h3>\n<input id=\"new-polygon\" type=\"submit\" value=\"Draw a Polygon\"/>");

  window.JST['area/add_polygon'] = _.template("<h3>Work Area #13</h3>\n<form id=\"validation-attributes\" onSubmit=\"return false;\">\n  <ul class=\"fields\">\n    <li>\n      <select name=\"type\">\n        <option value=\"add\">Add</option>\n        <option value=\"delete\">Delete</option>\n      </select>\n    </li>\n  </ul>\n  <input id=\"create-analysis\" type=\"submit\" value=\"Add\">\n</form>");

  window.JST['area/login'] = _.template("<h3>Please login</h3>\n<div class='error'></div>\n<form id=\"login-form\" onSubmit=\"return false;\">\n  <ul class=\"fields\">\n    <li>\n      <span>Email</span>\n      <input name=\"email\" value=\"decio.ferreira@unep-wcmc.org\"/>\n    </li>\n    <li>\n      <span>Password</span>\n      <input name=\"password\" type=\"password\" value=\"decioferreira\"/>\n    </li>\n  </ul>\n  <input id=\"login\" type=\"submit\" value=\"Login\">\n</form>");

  window.JST['area/area_index'] = _.template("<h2>Areas</h2>\n<ul id=\"area-list\">\n  <%\n    var i, len;\n    for (i=0,len=models.length; i<len; i=i+1){\n  %>\n    <li>\n      <h4><%= models[i].title %></h4>\n      <ul class='attributes'>\n        <li>Last updated:<span>11/12/2012</span></li>\n        <li>Data ready for trip:<span>√</span></li>\n      </ul>\n    </li>\n  <% } %>\n</ul>");

}).call(this);
