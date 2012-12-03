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
    <form id="polygon-attributes">
      <ul class="fields">
        <li>
          <select>
            <option value="add">Add</option>
            <option value="delete">Delete</option>
          </select>
        </li>
      </ul>
      <input id="create-polygon" type="submit" value="Add">
    </form>
  """
)
