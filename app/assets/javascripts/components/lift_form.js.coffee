coefficients = {1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8:786, 9: .765, 10: .944}
@LiftForm = React.createClass
  getInitialState: ->
    date: ''
    liftname: ''
    ismetric: false
    weightlifted: ''
    repsperformed: ''
    onerm: ''
  calculateOneRm: ->
    if @state.weightlifted and @state.repsperformed
      @state.onerm = @state.weightlifted / coefficients[@state.repsperformed]
    else
      0
  toggleUnit: (e) ->
    e.preventDefault()
    @setState ismetric: !@state.ismetric
  handleValueChange: (e) ->
    valueName = e.target.name
    @setState "#{ valueName }" : e.target.value
  valid: ->
    @state.date && @state.liftname && @state.weightlifted && @state.repsperformed && @state.onerm
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { lift: @state }, (data) =>
      @props.handleNewLift data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.div
      className: 'row'
      React.DOM.div
        className: 'col-xs-12 col-md-12 col-xl-12'
        React.DOM.form
          className: 'form-inline'
          onSubmit: @handleSubmit
          React.DOM.div
            className: 'form-group pad-r5'
            React.DOM.input
              type: 'date'
              className: 'form-control'
              placeholder: 'date'
              name: 'date'
              value: @state.date
              onChange: @handleValueChange
          React.DOM.div
            className: 'form-group pad-r5'
            React.DOM.input
              type: 'text'
              className: 'form-control'
              placeholder: 'liftname'
              name: 'liftname'
              value: @state.liftname
              onChange: @handleValueChange
          React.DOM.div
            className: 'form-group pad-r5'
            React.DOM.button
              className: 'btn btn-primary'
              onClick: @toggleUnit
              'Metric = ' + @state.ismetric.toString()
          React.DOM.div
            className: 'form-group pad-r5'
            React.DOM.input
              type: 'number'
              className: 'form-control'
              placeholder: 'weightlifted'
              name: 'weightlifted'
              value: @state.weightlifted
              onChange: @handleValueChange
          React.DOM.div
            className: 'form-group pad-r5'
            React.DOM.input
              type: 'number'
              min: 0
              max: 10
              className: 'form-control'
              placeholder: 'repsperformed'
              name: 'repsperformed'
              size: 10
              value: @state.repsperformed
              onChange: @handleValueChange
          React.DOM.div
            className: 'form-group pad-r5'
            React.DOM.button
              type: 'submit'
              className: 'btn btn-success'
              disabled: !@valid()
              'Create lift'
      React.DOM.div
        className: 'col-xs-12 col-md-12 col-xl-12'
        React.createElement OneRmBox, onerm: @calculateOneRm()
