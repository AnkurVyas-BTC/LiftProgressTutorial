BG_COLOR_CLASS = {incomplete: 'table-danger', wip: 'table-warning', completed: 'table-success'}
@Task = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/tasks/#{ @props.task.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteTask @props.task
  handleEdit: (e) ->
    e.preventDefault()
    data =
      description: ReactDOM.findDOMNode(@refs.taskname).value
      user_id: ReactDOM.findDOMNode(@refs.user_id).value
      status: ReactDOM.findDOMNode(@refs.status).value
    $.ajax
      method: 'PUT'
      url: "/tasks/#{ @props.task.id }"
      dataType: 'JSON'
      data:
        task: data
      success: (data) =>
        @setState edit: false
        @props.handleEditTask @props.task, data
  taskRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.task.description
      React.DOM.td null, @props.task.username
      React.DOM.td
        className: BG_COLOR_CLASS[@props.task.status]
        @props.task.status
      React.DOM.td null,
        React.DOM.span
          className: 'btn btn-primary mar-r5'
          onClick: @handleToggle
          'Edit'
        React.DOM.span
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  taskForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.task.description
          ref: 'taskname'
      React.DOM.td null,
        React.DOM.div
          className: 'form-group'
          React.DOM.div
            React.DOM.select
              className: 'form-control'
              ref: 'user_id'
              for user in @props.users
                if @props.task.user_id == user.id
                  React.DOM.option
                    key: user.id
                    value: user.id
                    selected: 'selected'
                    user.name
                else
                  React.DOM.option
                    key: user.id
                    value: user.id
                    user.name
      React.DOM.td null,
        React.DOM.div
          className: 'form-group'
          React.DOM.div
            React.DOM.select
              className: 'form-control'
              ref: 'status'
              for status in @props.statuses
                if @props.task.status == status
                  React.DOM.option
                    key: status
                    value: status
                    selected: 'selected'
                    status
                else
                  React.DOM.option
                    key: status
                    value: status
                    status
      React.DOM.td null,
        React.DOM.span
          className: 'btn btn-success mar-r5'
          onClick: @handleEdit
          'Update'
        React.DOM.span
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @taskForm()
    else
      @taskRow()
