# Touch
$ = jQuery = require 'jquery'
module.exports =
class TouchEvent
  constructor: (@callBack) ->
    $(document).ready @init

  init: =>
    document.body.addEventListener 'touchstart',@touch
    document.body.addEventListener 'touchmove',@touch
    document.body.addEventListener 'touchend',@touch
    document.body.addEventListener 'touchcancel',@touch

  #calculate the x and y average
  average: (touches) ->
    x = 0
    y = 0
    for touch in touches
      x+=touch.clientX
      y+=touch.clientY
    return {} =
      x : x/touches.length
      y : y/touches.length

  startE: null #startEvent
  lastTouchE: null #lst Touch Event
  addDirections: (e) ->
    e.direction = {} =
      left: e.avg.x
      right: window.innerWidth - e.avg.x
      top: e.avg.y
      bottom: window.innerHeight - e.avg.y
  touch: (e) =>
    if e.type != 'touchend'
      e.avg = @average e.touches
      if @startE?
        e.avg.diff =
          x: e.avg.x - @startE.avg.x
          y: e.avg.y - @startE.avg.y
      @lastTouchE = e
      @addDirections e
    if e.type == 'touchstart'
      e.start=true
      @startE = e
    else if e.type == 'touchmove'
      e.move=true
    else # 'touchend'
      # e.end=true
      console.log e.touches
      e.lastTouchEvent=@lastTouchE

    @startE=null if e.end

    @callBack e
