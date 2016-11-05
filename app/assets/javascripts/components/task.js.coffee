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
      taskname: ReactDOM.findDOMNode(@refs.taskname).value
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
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.task.user_id
          ref: 'user_id'
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
