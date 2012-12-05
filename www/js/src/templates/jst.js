(function() {

  window.JST = {};

  window.JST['area/edit'] = _.template("<h3><%= area.get('title') %></h3>\n<input id=\"new-validation\" type=\"submit\" value=\"Add a validation\"/>");

  window.JST['area/add_polygon'] = _.template("<h3><%= area.get('title') %></h3>\n<form id=\"validation-attributes\" onSubmit=\"return false;\">\n  <ul class=\"fields\">\n    <li>\n      <select name=\"type\">\n        <option value=\"add\">Add</option>\n        <option value=\"delete\">Delete</option>\n      </select>\n    </li>\n  </ul>\n  <input id=\"create-analysis\" type=\"submit\" value=\"Add\">\n</form>");

  window.JST['area/login'] = _.template("<h3>Please login</h3>\n<div class='error'></div>\n<form id=\"login-form\" onSubmit=\"return false;\">\n  <ul class=\"fields\">\n    <li>\n      <span>Email</span>\n      <input name=\"email\" value=\"decio.ferreira@unep-wcmc.org\"/>\n    </li>\n    <li>\n      <span>Password</span>\n      <input name=\"password\" type=\"password\" value=\"decioferreira\"/>\n    </li>\n  </ul>\n  <input id=\"login\" type=\"submit\" value=\"Login\">\n</form>");

  window.JST['area/area_index'] = _.template("<h2>Areas</h2>\n<ul id=\"area-list\">\n</ul>");

  window.JST['area/area'] = _.template("<li>\n  <div class='headline'>\n    <h3><%= area.get('title') %></h3>\n    <a class=\"start-trip btn\">Start trip</a>\n  </div>\n  <ul class='attributes'>\n    <li>Last updated:<span>11/12/2012</span></li>\n    <li>Data ready for trip:<span>√</span></li>\n  </ul>\n</li>");

}).call(this);
