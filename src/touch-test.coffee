$ = require 'jquery'

module.exports =
class TouchTest
  constructor: ->
    console.log "jo 1 2 3 4"
    touch.on(document.body).fingers.eq(3).call(@touchDown)
    @notifications = $ '<div />',
      id: 'notifications'
      css:
        background: 'red'
        width: '200px'
        height: '200px'
    $('body').append @notifications
  touchDown: (e) =>
    e.preventDefault()
    @notifications.text "X: #{e.avg.x}, Y: #{e.avg.y}"

$(document).ready ->
  new TouchTest()
