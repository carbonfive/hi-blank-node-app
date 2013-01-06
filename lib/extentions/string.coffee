###
Sources:
http://jamesroberts.name/blog/2010/02/22/string-functions-for-javascript-trim-to-camel-case-to-dashed-and-to-underscore/
###

# trim
String.prototype.trim ||= ()->
  @replace /^\s+|\s+$/g, ""

# ltrim
String.prototype.ltrim ||= ()->
  @replace /^\s+/g, ""

# rtrim
String.prototype.rtrim ||= ()->
  @replace /\s+$/g, ""

# array of tokens
String.prototype.tokens ||= (delim) ->
  list = @split(delim)
  list = (item.trim() for item in list)
  
# toCamel
String.prototype.toCamel ||= ()->
  @replace /(\-[a-z])/g, ($1)->
    $1.toUpperCase().replace('-','')

# dasherize
String.prototype.toDash ||= ()->
  @replace /([A-Z])/g, ($1)->
    return "-"+$1.toLowerCase()

#underscore
String.prototype.toUnderscore ||= ()-> 
  @replace /([A-Z])/g, ($1)->
    "_"+$1.toLowerCase()

# titleCase
String.prototype.toTitleCase ||= ()->
  @replace /(?:^|\s)\w/g, ($1)->
    $1.toUpperCase()

# file-name.coffee -> ClassName
String.prototype.toClassName = ()->
  (@replace '.coffee','').toCamel().toTitleCase()
