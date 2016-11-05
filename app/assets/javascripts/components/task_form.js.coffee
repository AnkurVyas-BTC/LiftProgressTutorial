@TaskForm = React.createClass
  getInitialState: ->
    description: ''
    user_id: 1
    status: 'incomplete'
  getDefaultProps: ->
    users: []
  handleValueChange: (e) ->
    valueName = e.target.name
    @setState "#{ valueName }" : e.target.value
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { task: @state }, (data) =>
      @props.handleNewTask data
      @setState @getInitialState()
    , 'JSON'
  valid: ->
    @state.description && @state.user_id
  render: ->
    React.DOM.div
      className: 'row'
      React.DOM.div
        className: 'col-xs-12'
        React.DOM.form
          onSubmit: @handleSubmit
          React.DOM.div
            className: 'form-group pad-r5 col-xs-6'
            React.DOM.input
              type: 'text'
              className: 'form-control'
              placeholder: 'Description'
              name: 'description'
              value: @state.description
              onChange: @handleValueChange
          React.DOM.div
            className: 'form-group pad-r5 col-xs-3'
            React.DOM.div
              React.DOM.select
                className: 'form-control'
                name: 'user_id'
                onChange: @handleValueChange
                for user in @props.users
                  React.DOM.option
                    key: user.id
                    value: user.id
                    user.name
          React.DOM.div
            className: 'form-group pad-r5 col-xs-3'
            React.DOM.div
              React.DOM.select
                className: 'form-control'
                name: 'status'
                onChange: @handleValueChange
                for status in @props.statuses
                  React.DOM.option
                    key: status
                    value: status
                    status
          React.DOM.div
            className: 'form-group pad-r5'
            React.DOM.button
              type: 'submit'
              className: 'btn btn-success btn-block'
              disabled: !@valid()
              'Create task'