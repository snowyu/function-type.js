#inherits        = require 'inherits-ex/lib/inherits'
isString        = require 'util-ex/lib/is/type/string'
isObject        = require 'util-ex/lib/is/type/object'

module.exports = class GlobalScope

  delimiter: '`'

  indexOf: (aItem)->
    for k, v of @
      return k if v is aItem

  itemToName: (aItem)->
    result = @indexOf aItem
    if result?
      result = @delimiter + result + @delimiter
    result

  isItemName: (aName)->
    result = isString(aName) and (vLen = aName.length) > 2
    if result
      vDelimiter = @delimiter
      result = aName[0] is vDelimiter and aName[vLen-1] is vDelimiter
    result

  nameToItem: (aName)->
    aName = aName.substring(1, aName.length-1)
    @[aName]

  # convert each scope item to name
  toName: (aScope)->
    if isObject(aScope)
      for k,v of aScope
        vName = @itemToName v
        aScope[k] = vName if vName
    aScope

  # convert each name to scope item
  toScope: (aScope)->
    for k,v of aScope
      # convert the string name to a globalScope item.
      if @isItemName v
        v = @nameToItem(v)
        aScope[k] = v if v isnt undefined
    aScope
