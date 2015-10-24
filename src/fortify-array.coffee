Array::inArray = (item) ->
  if @compare?
    for aItem in @
      return true if @compare item,aItem
  else console.log "ERROR: There is no Array.compare(a,b) Function."
  return false

Array::pushIfNotExist = (item) ->
  if not @inArray item
    return @push item
  return false
