# Touch
module.exports =
class TouchEvent
  constructor: (@callBack) ->
    # $(document).ready @init
    @documentReady @init

  #for no jquery depencies!
  documentReady: (callback) ->
    document.addEventListener "DOMContentLoaded", ->
        document.removeEventListener "DOMContentLoaded", arguments.callee, false
        callback()
    , false

  init: =>
    document.body.addEventListener 'touchstart',@touch
    document.body.addEventListener 'touchmove',@touch
    document.body.addEventListener 'touchend',@touch
    document.body.addEventListener 'touchcancel',@touch

  touch: (e) =>
    @_average e
    @_checkHomeStretch e
    # @callBack e
    # console.log e

  #Zielgerade
  _lastEnd: true
  _touchStartTimeout: null
  _checkHomeStretch: (e) ->
    # console.log e
    if e.type=='touchend' and e.touches.length==0
      e.end=true
      @_lastEnd=true
      @callBack e
    else if e.type=='touchmove' and @_lastEnd
      clearTimeout @_touchStartTimeout if @_touchStartTimeout!=null
      @_touchStartTimeout = setTimeout =>
        e.startFingers=e.touches.length
        e.start=true
        @_lastEnd=false
        @callBack e
      , 10
    else
      @callBack e

  #calculate the x and y average
  _average: (e) ->
    if e.touches.length>0
      x = 0
      y = 0
      for touch in e.touches
        x+=touch.clientX
        y+=touch.clientY
      e.avg = {} =
        x : x/e.touches.length
        y : y/e.touches.length

      @_addDirections e

  #add directions to
  _addDirections: (e) ->
    e.direction = {} =
      left: e.avg.x
      top: e.avg.y
      right: window.innerWidth - e.avg.x
      bottom: window.innerHeight - e.avg.y
