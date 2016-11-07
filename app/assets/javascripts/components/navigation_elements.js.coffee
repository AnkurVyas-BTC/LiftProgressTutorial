@NavigationElement = React.createClass
  getActiveClass: ->
    if @props.is_active then 'active' else ''
  render: ->
    React.DOM.li
      className: 'nav-item'
      React.DOM.a
        className: 'nav-link ' + @getActiveClass()
        href: @props.path_link
        @props.path_name