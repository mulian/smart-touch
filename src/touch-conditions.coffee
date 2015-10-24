# TouchConditions


module.exports =
class TouchConditions
  _initConditions: ->
    @conditions= {} = #there is no nee for others then touchstart or?
      touchstart: {}
      touchmove: {}
      touchend: {}
  _getCondition: ->
    return @conditions[@timing]
  _addCondition: (attr,value) ->
    @_getCondition()[attr] = value

  constructor: ->
    @_initConditions()
    @onStart() #default
    @fingers.head = @
    @move.head = @
    @from.head = @

    return @

  call: (@callback) ->
    return @


  onStart: ->
    @timing='touchstart'
    return @
  # onMove: ->
  #   @timing='touchmove'
  #   return @
  # onEnd: -> #no need?
  #   @timing='touchend'
  #   return @

  element: {} =
    eq: true
    above: true
    el: null

  #move from
  from: {} =
    left: (distance) ->
      distance ?= 50
      @head._addCondition 'from', {} =
        left: distance
      return @head
    right: (distance) ->
      distance ?= 50
      @head._addCondition 'from', {} =
        right: distance
      return @head
    top: (distance) ->
      distance ?= 50
      @head._addCondition 'from', {} =
        top: distance
      return @head
    bottom: (distance) ->
      distance ?= 50
      @head._addCondition 'from', {} =
        bottom: distance
      return @head

  # move with distance to activate
  move: {} =
    x: (distance) ->
      distance ?= 50
      @head._addCondition 'move', {} =
        x: distance
      return @head
    y: (distance) ->
      distance ?= 50
      @head._addCondition 'move', {} =
        y: distance
      return @head
    toRight: (distance) ->
      distance ?= 50 
      @head._addCondition 'move', {} =
        toRight: distance
      return @head
    toLeft: (distance) ->
      distance ?= 50
      @head._addCondition 'move', {} =
        toLeft: distance
      return @head
    toTop: (distance) ->
      distance ?= 50
      @head._addCondition 'move', {} =
        toTop: distance
      return @head
    toBottom: (distance) ->
      distance ?= 50
      @head._addCondition 'move', {} =
        toBottom: distance
      return @head

  fingers: {} =
    betweene: (from,to) ->
      @head._addCondition 'fingers', {} =
        from: from
        to: to
        betweene: true
      return @head
    eq: (eq) ->
      @head._addCondition 'fingers', {} =
        eq: eq
        equals: true
      return @head
