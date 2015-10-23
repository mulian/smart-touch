$ = require 'jquery'

module.exports =
class TouchTest
  constructor: ->
    touch.on(document.body).fingers.betweene(0,5).call(@touchDown)
    @notifications = $ '<div />',
      id: 'notifications'
      css:
        background: 'red'
        width: '90%'
        height: '90%'
    $('body').append @notifications
    # window.console.log = @log
  touchDown: (e) ->
    e.preventDefault()
    if e.end
      console.log "end touches: #{e.touches.length}"
    else
      console.log ""

    console.log "touches: #{e.touches.length}"
    console.log e

  log: (str) =>
    @notifications.text str


$(document).ready ->
  new TouchTest()
  console.log "asd"
