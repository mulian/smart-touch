$ = require 'jquery'

module.exports =
class TouchTest
  constructor: ->
    touch.on(document.body).fingers.betweene(3,3).call(@touchDown)
    # window.console.log = @log
  touchDown: (e) ->
    # console.log "touches: #{e.touches.length}"
    console.log e

  log: (str) =>
    @notifications.text str


$(document).ready ->
  new TouchTest()
  console.log "asd"
