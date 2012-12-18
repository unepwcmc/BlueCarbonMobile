window.JST = {}

window.JST['area/edit'] = _.template(
  """
    <div class='ios-head'>
      <a class='back'>Back</a>
      <h2><%= area.get('title') %></h2>
    </div>
    <% if (validationCount > 0) { %>
      <a id="upload-validations" class="btn btn-small">
        Upload validations
      </a>
    <% } %>
    <ul id='validation-list'></ul>
    <input id="new-validation" type="submit" value="Add a validation"/>
  """
)

window.JST['area/add_polygon'] = _.template(
  """
    <div class='ios-head'>
      <a class='back'>Area</a>
      <h2>Add Validation</h3>
    </div>
    <form id="validation-attributes" onSubmit="return false;">
      <input type='hidden' name='area_id' value="<%= area.get('id') %>"/>
      <ul class="fields">
        <li>
          <label>Name</label>
          <input type='text' name="name">
        </li>
        <li>
          <select name="action">
            <option value="add">Add</option>
            <option value="delete">Delete</option>
          </select>
        </li>
        <li>
          <label>Knowledge</label>
          <input type='text' name="knowledge">
        </li>
        <li>
          <label>Density</label>
          <input name="density">
        </li>
        <li>
          <label>Age</label>
          <input name="age">
        </li>
        <li>
          <select name="habitat">
            <option value="mangroves">Mangroves</option>
            <option value="seagrass">Seagrass</option>
          </select>
        </li>
      </ul>
      <input id="create-analysis" type="submit" value="Add">
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
    <div id="sync-status"></div>
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
        <img src="css/images/arrow_forward.png"\>
        <div>START TRIP</div>
      </div>
    <% } else if (downloadState === 'out of date' || downloadState === 'no data') { %>
      <div class="area-actions download-data">
        <img src="css/images/download_icon.png"\>
        <div>DOWNLOAD</div>
      </div>
    <% } else if (downloadState === 'data generating') { %>
      <div class='area-actions data-generating'>
        <img src="css/images/timer.gif"\>
        <div>GENERATING</div>
      </div>
    <% } %>
  """
)

window.JST['area/validation'] = _.template(
  """
    <%= validation.get('name') %> (<%= validation.get('action') %>)<a class='btn btn-small delete'>Delete</a>
  """
)
