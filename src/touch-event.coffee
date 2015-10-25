# Fortify Touch event Object.
# And add Listener to Dom.

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
        return true if a? and a.isEqualNode b
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
        pitch : @_calcPitch(e)

      @_addAverageDiff e
      #directions depence on .avg
      @_addDirections e


  #are there any Graph optimizations?
  # TODO: remove getPoints for better runtime?
  # Algorithm:
  # if there is only one point return 0
  # for any point
  #    create sublist without current point
  #    for sublist
  #       get pitch between point from first and secound for loop
  #       if pitch is greater then save
  # return greatest pitch
  _calcPitch: (e) ->
    return 0 if e.touches.length==1
    getPoint = (touch) ->
      return {} =
        x: touch.pageX
        y: touch.pageY
    getPoints = (touches) ->
      array = []
      for touch in e.touches
        getPoint touch
    getPitchBetween = (p1,p2) ->
      return Math.sqrt(Math.pow(p2.x-p1.x,2)+Math.pow(p2.y-p1.y,2))

    points = getPoints e.touches
    maxPitch = 0
    for p1,k in points
      pointsWithoutP1 = points.slice(0) #clone all points
      pointsWithoutP1.splice k,1 #remove current element from pointsWithoutP1
      for p2 in pointsWithoutP1
        pitch = getPitchBetween p1,p2
        if pitch>maxPitch
          maxPitch=pitch
    return maxPitch

  _addAverageDiff: (e) ->
    e.avg.diff = {} =
      x: e.avg.x-@_firstEvent.avg.x
      y: e.avg.y-@_firstEvent.avg.y
      pitch: e.avg.pitch-@_firstEvent.avg.pitch if @_firstEvent.avg.pitch>0
    # console.log @_firstEvent.avg.pitch
    # console.log e.avg.pitch

  #add directions to
  _addDirections: (e) ->
    e.direction = {} =
      left: e.avg.x
      top: e.avg.y
      right: window.innerWidth - e.avg.x
      bottom: window.innerHeight - e.avg.y
