@Tasks = React.createClass
  getInitialState: ->
    tasks: @props.tasks
    users: @props.users
    stats: @props.stats
    user_stats: @props.user_stats
  refreshStats: ->
    $.ajax
      method: 'GET'
      url: Routes.tasks_get_stats_path()
      dataType: 'JSON'
      success: (data) =>
        @setState stats: data.stats, user_stats: data.user_stats
  getTasks: (page)->
    $.ajax
      method: 'GET'
      url: Routes.tasks_get_tasks_path()
      dataType: 'JSON'
      data:
        page: page
      success: (data) =>
        @setState tasks: data.task_list
        @refreshStats()
  addTask: (task) ->
    @getTasks()
  componentDidMount: ->
    @getTasks()
  handlePaginationClick: (e) ->
    @getTasks($(e.target).text())
  deleteTask: (task) ->
    @getTasks()
  updateTask: (task, data) ->
    index = @state.tasks.indexOf task
    tasks = React.addons.update(@state.tasks, { $splice: [[index, 1, data]] })
    @setState tasks: tasks
    @refreshStats()
  render: ->
    React.DOM.div
      className: 'row pad-a25'
      React.DOM.div
        className: 'col-xs-12 pad-b20'
        React.createElement NavigationMenu, active_route: 'tasks'
      React.DOM.div
        className: 'col-xs-12'
        React.DOM.div
          className: 'col-xs-12'
          React.DOM.h1
            className: 'title'
            'Tasks'
      React.DOM.div
        className: 'col-xs-6'
        React.createElement TaskForm, handleNewTask: @addTask, users: @state.users, statuses: @props.statuses
        React.DOM.table
          className: 'table table-bordered table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Description'
              React.DOM.th null, 'Assigned To'
              React.DOM.th null, 'Status'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for task in @state.tasks
              React.createElement Task, key: task.id, task: task, handleDeleteTask: @deleteTask, handleEditTask: @updateTask, users: @state.users, statuses: @props.statuses
        React.DOM.div
          className: 'col-xs-12'
          React.DOM.nav
            React.DOM.ul
              className: 'pagination'
              for page in [1..@props.total_pages]
                  React.DOM.li
                    className: 'page-item'
                    React.DOM.span
                      className: 'page-link cursor-pointer'
                      value: page
                      onClick: @handlePaginationClick
                      page
      React.DOM.div
        className: 'col-xs-6'
        React.createElement TaskAnalytics, tasks: @state.tasks, statuses: @props.statuses, users: @state.users, stats: @state.stats, user_stats: @state.user_stats