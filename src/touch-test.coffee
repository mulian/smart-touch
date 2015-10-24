$ = require 'jquery'

module.exports =
class TouchTest
  constructor: ->
    $('body').css 'margin', '0px 0px 0px 0px'
    # touch.on(document.body,{allFingers:true}).fingers.betweene(1,3).call(@touchDown)

    # window.console.log = @log
    left = $ '<div />',
      id: 'left'
      css:
        width: '50%'
        height: '150%'
        background: 'red'
    right = $ '<div />',
      id: 'right'
      css:
        width: '50%'
        height: '100%'
        background: 'blue'
    $('body').append right
    $('body').append left
    touch.on(left[0]).fingers.betweene(1,3).from.left(50).call(@touchDown2)
    # left.scrollTop(1000)

  touchDown: (e) ->
    # console.log "touches: #{e.touches.length}"
    console.log "TOUCHDOWN"
    console.log e

  touchDown2: (e) ->
    console.log "TouchDown 2"

  log: (str) =>
    @notifications.text str


$(document).ready ->
  new TouchTest()
  console.log "asd"
