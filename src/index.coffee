isString        = require 'util-ex/lib/is/type/string'
isFunction      = require 'util-ex/lib/is/type/function'
isFunctionStr   = require 'util-ex/lib/is/string/function'
isObject        = require 'util-ex/lib/is/type/object'
extend          = require 'util-ex/lib/extend'
createFunc      = require 'util-ex/lib/_create-function'
Attributes      = require 'abstract-type/lib/attributes'
Type            = require 'abstract-type'
register        = Type.register
aliases         = Type.aliases

getObjKey = (obj, value)->
  for k,v of obj
    return k if v is value

module.exports = class FunctionType
  register FunctionType
  aliases  FunctionType, 'function', 'func', 'method', 'Method'

  constructor: ->
    return super

  $attributes: Attributes
    scope:
      type: 'Object'
    $globalScope:
      type: 'Object'

  _assign: (aOptions)->
    if aOptions
      vGlobalScope = aOptions.globalScope or aOptions.$globalScope
      @$globalScope = extend {}, vGlobalScope if isObject vGlobalScope
      vGlobalScope = @$globalScope

      vScope = aOptions.scope
      if vGlobalScope
        for k,v of vScope
          if isString(v) and vGlobalScope[v]?
            vScope[k] = vGlobalScope[v]
      @scope = extend {}, vScope
    return

  valueToString: (aValue)->String(aValue)
  toValue: (aValue)->
    if isString aValue
      createFunc aValue, @scope
    else
      aValue
  _toObject: (aOptions)->
    result = super
    vScope = result.scope
    vGlobal = @$globalScope
    if isObject(vScope) and isObject vGlobal
      for k,v of vScope
        vName = getObjKey(vGlobal, v)
        vScope[k] = vName if vName
    result
  _validate: (aValue, aOptions)->
    isFunction(aValue) or isFunctionStr(aValue)
