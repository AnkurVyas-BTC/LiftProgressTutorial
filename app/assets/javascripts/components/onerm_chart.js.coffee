@OneRmChart = React.createClass
  componentDidMount: ->
    @createChart @props
  componentDidUpdate: ->
    @createChart @props
  createChart: (props)->
    series_a_array = []
    props.lifts.map((lift) -> series_a_array.push([lift.date, lift.onerm]))
    series_b_array = []
    props.lifts.map((lift) -> series_b_array.push([lift.date, lift.weightlifted]))
    new Chartkick.LineChart("chart-1",[{ name: "1 Rm", data: series_a_array }, { name: "Weightlifted", data: series_b_array }], {'title':'How Much Pizza I Ate Last Night'});
  render: ->
    React.DOM.div
      style: {height: '350px'}
      id: 'chart-1'