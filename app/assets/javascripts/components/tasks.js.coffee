@Tasks = React.createClass
  getInitialState: ->
    tasks: @props.data
    users: @props.users
  addTask: (task) ->
    tasks = @state.tasks.slice()
    tasks.push task
    @setState tasks: tasks
  componentDidMount: ->
    $.ajax
      method: 'GET'
      url: "/tasks"
      dataType: 'JSON'
      success: (data) =>
        @setState tasks: data
  deleteTask: (task) ->
    tasks = @state.tasks.slice()
    index = tasks.indexOf task
    tasks.splice index, 1
    @setState tasks: tasks
  updateTask: (task, data) ->
    index = @state.tasks.indexOf task
    tasks = React.addons.update(@state.tasks, { $splice: [[index, 1, data]] })
    @setState tasks: tasks
  render: ->
    React.DOM.div
      className: 'row pad-a25'
      React.DOM.div
        className: 'col-xs-12 pad-b20'
        React.createElement NavigationMenu
      React.DOM.div
        className: 'col-xs-12'
        React.DOM.div
          className: 'col-xs-12'
          React.DOM.h1
            className: 'title'
            'Tasks'
      React.DOM.div
        className: 'col-xs-6'
        React.createElement TaskForm, handleNewTask: @addTask, users: @state.users
        React.DOM.table
          className: 'table table-bordered table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Description'
              React.DOM.th null, 'Assigned To'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for task in @state.tasks
              React.createElement Task, key: task.id, task: task, handleDeleteTask: @deleteTask, handleEditTask: @updateTask