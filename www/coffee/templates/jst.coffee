window.JST = {}

window.JST['area/edit'] = _.template(
  """
    <h3>Work Area #13</h3>
    <input id="new-polygon" type="submit" value="Draw a Polygon"/>
  """
)

window.JST['area/add_polygon'] = _.template(
  """
    <h3>Work Area #13</h3>
    <form id="validation-attributes" onSubmit="return false;">
      <ul class="fields">
        <li>
          <select name="type">
            <option value="add">Add</option>
            <option value="delete">Delete</option>
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
    <h3>Areas</h3>
    <ul id="area-list">
      <%
        var i, len;
        for (i=0,len=models.length; i<len; i=i+1){
      %>
        <li>
          <h4><%= models[i].title %></h4>
        </li>
      <% } %>
    </ul>
  """
)
