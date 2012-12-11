(function() {

  window.JST = {};

  window.JST['area/edit'] = _.template("<div class='ios-head'>\n  <a class='back'>Back</a>\n  <h2><%= area.get('title') %></h2>\n</div>\n<ul id='validation-list'></ul>\n<input id=\"new-validation\" type=\"submit\" value=\"Add a validation\"/>");

  window.JST['area/add_polygon'] = _.template("<div class='ios-head'>\n  <a class='back'>Area</a>\n  <h2>Add Validation</h3>\n</div>\n<form id=\"validation-attributes\" onSubmit=\"return false;\">\n  <input type='hidden' name='area_id' value=\"<%= area.get('id') %>\"/>\n  <ul class=\"fields\">\n    <li>\n      <select name=\"type\">\n        <option value=\"add\">Add</option>\n        <option value=\"delete\">Delete</option>\n      </select>\n    </li>\n  </ul>\n  <input id=\"create-analysis\" type=\"submit\" value=\"Add\">\n</form>");

  window.JST['area/login'] = _.template("<h3>Please login</h3>\n<div class='error'></div>\n<form id=\"login-form\" onSubmit=\"return false;\">\n  <ul class=\"fields\">\n    <li>\n      <span>Email</span>\n      <input name=\"email\" value=\"decio.ferreira@unep-wcmc.org\"/>\n    </li>\n    <li>\n      <span>Password</span>\n      <input name=\"password\" type=\"password\" value=\"decioferreira\"/>\n    </li>\n  </ul>\n  <input id=\"login\" type=\"submit\" value=\"Login\">\n</form>");

  window.JST['area/area_index'] = _.template("<div class='ios-head'>\n  <h2>Areas</h2>\n</div>\n<div id=\"sync-status\"></div>\n<ul id=\"area-list\">\n</ul>");

  window.JST['area/area'] = _.template("<div class='headline'>\n  <h3><%= area.title %></h3>\n  <% if (area.downloaded_data) { %>\n    <a class=\"start-trip btn btn-small\">\n      Start Trip\n    </a>\n  <% } else { %>\n    <a class=\"download-data btn btn-small\">\n      Download the data\n    </a>\n  <% } %>\n</div>\n<ul class='attributes'>\n  <li>Last updated:<span>11/12/2012</span></li>\n</ul>");

  window.JST['area/validation'] = _.template("<%= validation.get('type') %> at 11/11/2013");

}).call(this);
