global.isPresent = (obj)->
  return true for own key, val of obj
  return false

global.isEmpty = (obj)-> not isPresent(obj)
