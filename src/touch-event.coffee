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

  #init touch events
  init: =>
    document.body.addEventListener 'touchstart',@touch
    document.body.addEventListener 'touchmove',@touch
    document.body.addEventListener 'touchend',@touch
    document.body.addEventListener 'touchcancel',@touch

  #call on every touch event
  touch: (e) =>
    if e.type=='touchstart' and @_lastEnd and @_touchStartCound==0
      @_firstEvent = e
    @_addCurrentTarget e
    @_addAverage e
    @_checkHomeStretch e

  #Zielgerade
  # It calls the callBack
  _lastEnd: true
  _touchStartTimeout: null
  _touchStartCound: 0
  _checkHomeStretch: (e) ->
    if e.type=='touchend' and e.touches.length==0
      e.end=true
      @_lastEnd=true
      @callBack e
    #call it only, if he really knows how many fingers u use
    else if e.type=='touchmove' and @_lastEnd and @_touchStartCound<10
      # console.log @_touchStartCound
      @_touchStartCound++
      clearTimeout @_touchStartTimeout if @_touchStartTimeout!=null
      @_touchStartTimeout = setTimeout =>
        e.startFingers=e.touches.length
        e.start=true
        @_touchStartCound=0
        @_lastEnd=false
        @callBack e
      , 15
    else
      @callBack e

  #Add Target to touches
  _addCurrentTarget: (e) ->
    if e.touches.length>0
      for touch in e.touches
        touch.element = document.elementFromPoint(touch.clientX, touch.clientY)


  #calculate the x and y average
  #and the elements of touches
  _addAverage: (e) ->
    if e.touches.length>0
      elements = []
      elements.compare = (a,b) ->
        return true if a.isEqualNode b
        return false
      x = 0
      y = 0
      for touch in e.touches
        x+=touch.pageX
        y+=touch.pageY
        elements.pushIfNotExist touch.element
      e.avg = {} =
        x : x/e.touches.length
        y : y/e.touches.length
        elements : elements

      @_addAverageDiff e
      #directions depence on .avg
      @_addDirections e


  _addAverageDiff: (e) ->
    e.avg.diff = {} =
      x: e.avg.x-@_firstEvent.avg.x
      y: e.avg.y-@_firstEvent.avg.y

  #add directions to
  _addDirections: (e) ->
    e.direction = {} =
      left: e.avg.x
      top: e.avg.y
      right: window.innerWidth - e.avg.x
      bottom: window.innerHeight - e.avg.y
