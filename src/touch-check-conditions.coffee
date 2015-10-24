# Touch

module.exports =
class TouchCheckConditions
  constructor: (@setCall,@conditions) ->

  resetConditions: ->
    for con in @conditions
      con.checkBit=null

  allConditionsCheck: (e) ->
    for con in @conditions
      @checkStartConditions con,e
  checkStartConditions: (con,e) ->
    con.checkBit=true
    #check element?
    obj = con.conditions['touchstart']

    if con.checkBit
      @checkElement con,e
    if con.checkBit and obj.fingers?
      @checkFingers(con,e)
    if con.checkBit and obj.from?
      @checkFrom(con,e)

    if con.checkBit
      @setCall con.callback if con.checkBit

  checkFrom: (con,e) ->
    check = false
    from = con.conditions['touchstart'].from
    console.log "#{e.avg.x},#{from.left}"
    #check
    # if from.left? and e.avg.diff.x>0 #right move
      # console.log "right move"
    if (from.left? and e.avg.diff.x>0 and e.direction.left<from.left) or
       (from.right? and e.avg.diff.x<0 and e.direction.right<from.right)
      check=true

    con.checkBit=check



  checkElement: (con,e) ->
    element = con.element
    elements = e.avg.elements
    # console.log elements.compare
    console.log "ERROR: element.eq==element.neq" if element.neq==element.eq
    isIn = elements.inArray element.el
    if not ((isIn and element.eq) or (not isIn and element.neq))
      con.checkBit=false
      console.log "not eq isIn:#{isIn}"
    if (element.allFingers and elements.length>1)
      console.log "not allFingers"
      con.checkBit=false
    # console.log con
    if not con.checkBit
      console.log "Error: checkElement"

  checkFingers: (con,e) ->
    fingers = con.conditions['touchstart'].fingers
    fingerCount = e.touches.length
    console.log fingerCount
    if fingers.betweene?
      if not (fingerCount>=fingers.from and fingerCount<=fingers.to)
        con.checkBit=false
    else if fingers.equals?
      if fingerCount!=fingers.eq
        con.checkBit=false
    con.conditions
    # check
