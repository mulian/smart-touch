# Touch

module.exports =
class TouchCheckConditions
  constructor: (@setCall,@conditions) ->

  #Reset Conditions for next check
  # TODO: dont use checkBit on con
  resetConditions: ->
    for con in @conditions
      con.checkBit=null

  # get all Conditions and check
  allConditionsCheck: (e) ->
    for con in @conditions
      @checkStartConditions con,e

  # Check all Conditions
  checkStartConditions: (con,e) ->
    con.checkBit=true
    #check element?
    obj = con.conditions['touchstart']

    if con.checkBit #Every condition got an element
      con.checkBit=@checkElement con,e
    if con.checkBit and obj.move?
      con.checkBit=@checkMove con,e
    if con.checkBit and obj.fingers?
      con.checkBit=@checkFingers(con,e)
    if con.checkBit and obj.from?
      con.checkBit=@checkFrom(con,e)

    if con.checkBit
      @setCall con.callback if con.checkBit

  # Check side move 'from' left...
  # TODO: move from element side
  checkFrom: (con,e) ->
    from = con.conditions['touchstart'].from
    if (from.left? and e.avg.diff.x>0 and e.direction.left<from.left) or
       (from.right? and e.avg.diff.x<0 and e.direction.right<from.right) or
       (from.top? and e.avg.diff.y>0 and e.direction.top<from.top) or
       (from.bottom? and e.avg.diff.y<0 and e.direction.bottom<from.bottom)
      return true
    return false

  # Check the move direction if enabled
  checkMove: (con,e) ->
    move = con.conditions['touchstart'].move
    if (move.x? and not ((move.x*-1)<e.avg.diff.x<move.x) and ((move.x*-1)<e.avg.diff.y<move.x)) or
       (move.y? and not ((move.y*-1)<e.avg.diff.y<move.y) and ((move.y*-1)<e.avg.diff.x<move.y)) or
       (move.toLeft? and (move.toLeft<(e.avg.diff.x*-1))) or
       (move.toRight? and e.avg.diff.x>move.toRight) or
       (move.toBottom? and e.avg.diff.y>move.toBottom) or
       (move.toTop? and (e.avg.diff.y*-1)>move.toTop)
      return true
    return false

  # Dom Element=elmt
  # elmt.eq == more or eq one finger on elmt
  #
  # Table:
  # | elmt.eq | elmt.above | Description                               |
  # | ------- | ---------- | ----------------------------------------- |
  # |  true   |   true     | Touch on Element or above (on dom branch) |
  # |  true   |   false    | Touch only on element                     |
  # |  false  |   true     | Touch not on Element, but on above        |
  # |  false  |   false    | Touch anywere not on and above            |
  checkElement: (con,e) ->
    check = false
    elmt = con.element
    elements = e.avg.elements
    #check if elmt is in
    isIn = elements.inArray elmt.el
    if elmt.eq==isIn == true
      return true
    isAbove = false
    if not isIn #check all elmts above (>) the con.elmt
      tmpElmt = elmt.el
      while (not tmpElmt.isEqualNode(document.body))
        tmpElmt = tmpElmt.parentNode
        if elements.inArray tmpElmt
          isAbove = true
          break;
    if elmt.above==isAbove==true
      return true
    if elmt.above==isAbove==isIn==elmt.eq==false
      return true
    return false

  # Check the fingers count
  checkFingers: (con,e) ->
    fingers = con.conditions['touchstart'].fingers
    fingerCount = e.touches.length
    # console.log fingerCount
    if fingers.betweene?
      if not (fingerCount>=fingers.from and fingerCount<=fingers.to)
        return false
    else if fingers.equals?
      if fingerCount!=fingers.eq
        return false
    return true
