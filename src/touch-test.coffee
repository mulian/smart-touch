# Only for Test cases!

$ = require 'jquery'

module.exports =
class TouchTest
  constructor: ->
    $('body').css 'margin', '0px 0px 0px 0px'
    # touch.on(document.body,{allFingers:true}).fingers.betweene(1,3).call(@touchDown)

    # window.console.log = @log
    red = $ '<span />',
      id: 'red'
      css:
        display: 'inline-block'
        width: '50%'
        height: '150%'
        background: 'red'
    @blue = $ '<span />',
      id: 'blue'
      css:
        position: 'absolute'
        display: 'block'
        width: '50%'
        height: '100%'
        background: 'blue'
    $('body').append @blue
    # $('body').append red
    # touch.on(red[0],{eq:true,above:true}).fingers.betweene(1,3).call(@touchDown2) #1
    # touch.on(red[0],{eq:true,above:false}).fingers.betweene(1,3).call(@touchDown2) #2
    # touch.on(red[0],{eq:false,above:true}).fingers.betweene(1,3).call(@touchDown2) #3
    # touch.on(red[0],{eq:false,above:false}).fingers.betweene(1,3).call(@touchDown2) #4
    # left.scrollTop(1000)

    # touch.on(red[0],{eq:true,above:true}).fingers.betweene(1,3).move.toTop().call(@touchDown2)
    # touch.on(red[0],{eq:true,above:true}).fingers.betweene(2,3).move.toLeft().call(@touchDown)


    # touch.on(document.body).fingers.betweene(1,5).from.bottom().call(@touchDown2)
    # touch.on().fingers.betweene(1,3).call(@touchDown2)
    touch.on().fingers.eq(4).pinch.in().call(@pinch)

  touchDown: (e) ->
    # console.log "touches: #{e.touches.length}"
    console.log "TOUCHDOWN"
    console.log e

  _maxPitch: 999
  _lastPercent: 100
  pinch: (e) =>
    if e.start
      @blue.show()
      @_maxPitch = e.avg.pitch
      @_lastPercent= 100
    if not e.end?
      percent = (e.avg.diff.pitch*-1)/(@_maxPitch/100)
      @_lastPercent=percent if e.touches.length>=4
      if @_lastPercent<80
        @blue.css 'left',"#{@_lastPercent-80}%"
      else @blue.css 'left',"0px"
    else #aka. on e.end==ture
      if @_lastPercent>60
        @blue.css 'left',"0px"
      else
        @blue.hide()


  touchDown2: (e) ->
    console.log "TouchDown!"
    # console.log e

  log: (str) =>
    @notifications.text str


$(document).ready ->
  new TouchTest()
  console.log "asd"
