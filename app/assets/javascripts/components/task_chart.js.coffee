@TaskChart = React.createClass
  componentDidMount: ->
    @createChart @props
  componentDidUpdate: ->
    @createChart @props
  createChart: (props)->
    new Chartkick.PieChart('user-chart-' + @props.chart_id, props.chart_data, { colors: ["#D9534F", "#F0AD4E", "#5CB85C"], "library": {legend: {position: "bottom"}}});
  render: ->
    React.DOM.div
      style: {height: '250px'}
      id: 'user-chart-' + @props.chart_id