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
    <form id="validation-attributes" onSubmit="return false;">
      <ul class="fields">
        <li>
          <span>Username</span>
          <input name="username"/>
        </li>
        <li>
          <span>Password</span>
          <input name="Password" type="password"/>
        </li>
      </ul>
      <input id="create-analysis" type="submit" value="Login">
    </form>
  """
)
