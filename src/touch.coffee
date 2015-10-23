# Touch
TouchEvent = require './touch-event'
TouchConditions = require './touch-conditions'
TouchCheckConditions = require './touch-check-conditions'
TouchTest = require './touch-test'

module.exports =
class Touch
  conditions: []
  constructor: ->
    @touchEvent = new TouchEvent @trigger
    @check = new TouchCheckConditions @setCall, @conditions

  setCall: (@call) =>
  call: null
  trigger: (e) =>
    if @call==null
      @check.allConditionsCheck e if e.start
    else
      @call e

    if e.end
      @call = null
      @check.resetConditions()
    # console.log e

  newCondition: ->
    con = new TouchConditions()
    @conditions.push con
    return con
  on: (element) ->
    con = @newCondition()
    con.element = element
    return con


console.log "test BLUBB asd test 1 2 3 4 6 8"
window.touch = new Touch()
