@NavigationMenu = React.createClass
  render: ->
    React.DOM.nav
      className: 'navbar navbar-dark bg-inverse'
      React.DOM.ul
        className: 'nav navbar-nav'
        React.DOM.li
          className: 'nav-item active'
          React.DOM.a
            className: 'nav-link'
            href: '#'
            'Lifts'
        React.DOM.li
          className: 'nav-item'
          React.DOM.a
            className: 'nav-link'
            href: '#'
            'Tasks'