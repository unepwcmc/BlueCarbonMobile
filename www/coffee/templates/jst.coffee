window.JST = {}

window.JST['area/edit'] = _.template(
  """
    <div class='ios-head'>
      <a class='back'>Back</a>
      <h2><%= area.get('title') %></h2>
    </div>
    <a id="new-validation" class="btn btn-large">New Validation</a>
    <ul id='validation-list'></ul>
    <% if (validationCount > 0) { %>
      <a id="upload-validations" class="btn">
        <span>Upload Validations</span>
        <img src="css/images/upload.png"/>
      </a>
    <% } %>
  """
)

window.JST['area/add_polygon'] = _.template(
  """
    <div class='ios-head'>
      <a class='back'>Area</a>
      <h2>Add Validation</h3>
    </div>
    <div id='draw-polygon-notice'>
      Draw your polygon by tapping on the map
    </div>
    <form id="validation-attributes" onSubmit="return false;">
      <input type='hidden' name='area_id' value="<%= area.get('id') %>"/>
      <ul class="fields">
        <li>
          <label>Habitat</label>
          <select name="habitat">
            <option value="">Select a habitat layer</option>
            <option value="mangrove">Mangrove</option>
            <option value="seagrass">Seagrass</option>
            <option value="sabkha">Sabkha</option>
            <option value="salt-marsh">Salt Marsh</option>
          </select>
        </li>
        <li>
          <label>Validation Type</label>
          <select name="action">
            <option value="">Select Validation Type</option>
            <option value="add">Add</option>
            <option value="delete">Delete</option>
          </select>
        </li>
        <div id='validation-details'>
          <li class="conditional seagrass mangrove salt-marsh">
            <label>Density</label>
            <select name="density">
              <option value="">Unknown</option>
              <option value="1">Sparse (<20% cover)</option>
              <option value="2">Moderate (20-50% cover)</option>
              <option value="3">Dense (50-80% cover)</option>
              <option value="4">Very dense (>80% cover)</option>
            </select>
          </li>
          <li class="conditional mangrove">
            <label>Condition</label>
            <select name="condition">
              <option value="1">Undisturbed / Intact</option>
              <option value="2">Degraded</option>
              <option value="3">Restored / Rehabilitating</option>
              <option value="4">Afforested/ Created</option>
              <option value="5">Cleared</option>
            </select>
          </li>
          <li class="conditional mangrove">
            <label>Age</label>
            <select name="age">
              <option value="">Unknown</option>
              <option value="1">Natural Mangrove</option>
              <option value="2">2-10 yrs old</option>
              <option value="3">10-25 yrs old</option>
              <option value="4">25-50 yrs old</option>
            </select>
          </li>
          <li class="conditional seagrass">
            <label>Species</label>
            <select name="species">
              <option value="">Unknown</option>
              <option value="Halodule uninervis">Halodule uninervis</option>
              <option value="Halophila ovalis">Halophila ovalis</option>
              <option value="Halophila stipulacea">Halophila stipulacea</option>
              <option value="Mixed species">Mixed species</option>
            </select>
          </li>
          <li>
            <label>Name</label>
            <input type='text' name="name">
          </li>
          <li>
            <label>Knowledge</label>
            <input type='text' name="knowledge">
          </li>
        </div>
      </ul>
      <a id="create-analysis" class="btn btn-large">Save</a>
    </form>
  """
)

window.JST['area/login'] = _.template(
  """
    <h3>Please login</h3>
    <div class='error'></div>
    <form id="login-form" onSubmit="return false;">
      <ul class="fields">
        <li>
          <span>Email</span>
          <input name="email" value="decio.ferreira@unep-wcmc.org"/>
        </li>
        <li>
          <span>Password</span>
          <input name="password" type="password" value="decioferreira"/>
        </li>
      </ul>
      <input id="login" type="submit" value="Login">
    </form>
  """
)

window.JST['area/area_index'] = _.template(
  """
    <div class='ios-head'>
      <h2>Areas</h2>
    </div>
    <div id="sync-info">
      <span id="sync-status"></span>
      <span><a class="sync-areas">Sync</a></span>
    </div>
    <ul id="area-list">
    </ul>
  """
)

window.JST['area/area'] = _.template(
  """
    <div class='area-attributes'>
      <h3><%= area.get('title') %></h3>
      <p>
        <%
        var downloadState = area.downloadState();
        if (downloadState === 'out of date') {
        %>
          Habitat data is out of date
        <% } else if (downloadState === 'no data') { %>
          Habitat data not yet downloaded
        <% } else { %>
          Data downloaded at: <%= area.lastDownloaded() %>
        <% } %>
      </p>
    </div>
    <% if (false || downloadState === 'ready') { %>
      <div class="area-actions start-trip">
        <img src="css/images/arrow_forward.png"/>
        <div>START TRIP</div>
      </div>
    <% } else if (downloadState === 'out of date' || downloadState === 'no data') { %>
      <div class="area-actions download-data">
        <img src="css/images/download_icon.png"/>
        <div>DOWNLOAD</div>
      </div>
    <% } else if (downloadState === 'data generating') { %>
      <div class='area-actions data-generating'>
        <img src="css/images/timer.gif"/>
        <div>GENERATING</div>
      </div>
    <% } %>
  """
)

window.JST['area/validation'] = _.template(
  """
    <%= validation.get('name') %> (<%= validation.get('action') %>)<img class='delete-validation' src="css/images/trash_can.png"/>
  """
)
