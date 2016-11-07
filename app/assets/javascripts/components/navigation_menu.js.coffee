@NavigationMenu = React.createClass
  checkActiveRoute: (route) ->
    @props.active_route == route
  render: ->
    React.DOM.nav
      className: 'navbar navbar-dark bg-inverse'
      React.DOM.ul
        className: 'nav navbar-nav'
        React.createElement NavigationElement, key: 'lifts', path_link: Routes.lifts_path(), path_name: 'Lifts', is_active: @checkActiveRoute('lifts')
        React.createElement NavigationElement, key: 'tasks', path_link: Routes.tasks_path(), path_name: 'Tasks', is_active: @checkActiveRoute('tasks')