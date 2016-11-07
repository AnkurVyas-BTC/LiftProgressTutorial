PROGRESS_COLOR_CLASS = {incomplete: 'progress-danger', wip: 'progress-warning', completed: 'progress-success'}
TAG_COLOR_CLASS = {incomplete: 'tag-danger', wip: 'tag-warning', completed: 'tag-success'}
@TaskAnalytics = React.createClass
  capitalizeFirstLetter: (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)
  countTasksPerStatus: (status, tasks) ->
    tasks.filter((task) => ( task.status == status)).length
  countTasksPerUser: (username) ->
    @props.tasks.filter((task) => ( task.username == username)).length
  createDataForPieChart: (user)->
    newr = []
    for status in @props.statuses
      arr = []
      arr.push status
      arr.push user[status]
      newr.push arr
    newr
  render: ->
    React.DOM.div null,
      React.DOM.div
        className: 'col-md-12'
        React.DOM.table
          className: 'table table-bordered table-striped'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Total Tasks'
              for status in @props.statuses
                React.DOM.th null,
                  React.DOM.span
                    className: 'tag tag-default ' + TAG_COLOR_CLASS[status]
                    @capitalizeFirstLetter(status)
          React.DOM.tbody null,
            React.DOM.tr null,
              React.DOM.td null,
                @props.stats.total_tasks
              for status in @props.statuses
                React.DOM.td null,
                  @props.stats[status]
        for status in @props.statuses
          React.DOM.progress
            className: 'progress progress-striped progress-animated ' + PROGRESS_COLOR_CLASS[status]
            value: @props.stats[status]
            max: @props.stats.total_tasks
      React.DOM.div
        for user in @props.user_stats
          React.DOM.div
            className: 'col-md-6'
            React.DOM.div
              className: 'card card-block card-outline-primary'
              React.DOM.h4
                className: 'card-title'
                user.name
              React.DOM.div
                className: 'card-text'
                React.createElement TaskChart, chart_data: @createDataForPieChart(user), chart_id: user.id

