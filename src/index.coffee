isString        = require 'util-ex/lib/is/type/string'
isFunction      = require 'util-ex/lib/is/type/function'
isFunctionStr   = require 'util-ex/lib/is/string/function'
isObject        = require 'util-ex/lib/is/type/object'
extend          = require 'util-ex/lib/_extend'
#TODO: should use vm.createInContext? https://github.com/dfkaye/vm-shim
createFunc      = require 'util-ex/lib/_create-function'
Attributes      = require 'abstract-type/lib/attributes'
Type            = require 'abstract-type'
GlobalScope     = require './global-scope'
FunctionValue   = require './value'
register        = Type.register
aliases         = Type.aliases

getObjKeyByValue = (obj, value)->
  for k,v of obj
    return k if v is value

module.exports = class FunctionType
  register FunctionType
  aliases  FunctionType, 'function', 'func', 'method', 'Method'

  constructor: ->
    return super

  ValueType: FunctionValue
  $attributes: Attributes
    globalScope:
      type: 'Object'
    global:
      exported: false
      type: 'Object'
      assigned: '' #enable smart-assignment
      assign: (value, dest)->
        result = new GlobalScope
        extend result, value

  _assign: (aOptions)->
    if aOptions
      vGlobal = @$attributes.getValue aOptions, 'global'
      @global = extend new GlobalScope, vGlobal if isObject vGlobal
      vGlobal = @global

      vGlobalScope = aOptions.globalScope
      @globalScope = extend {}, vGlobalScope
      vGlobal.toScope @globalScope if vGlobal
    return

  toValue: (aValue, aOptions)->
    vScope = aOptions && aOptions.scope
    if isObject aValue
      vValueScope = aValue.scope
      aValue = aValue.function
    if isFunction(aValue)
      if !aValue.hasOwnProperty('scope') or vScope
        aValue = String(aValue)
        vValueScope = aValue.scope
      else
        result = aValue
    if isString aValue
      if vScope or vValueScope
        vValueScope = extend {}, vValueScope, vScope
        @global.toScope vValueScope if @global
        vScope = extend {}, @globalScope, vValueScope if @globalScope
      result = createFunc aValue, vScope
      result.scope = vValueScope
    result

  _toObject: (aOptions)->
    result = super
    vScope = result.globalScope
    vGlobal = @global
    vGlobal.toName vScope if isObject(vScope) and isObject vGlobal
    result

  _validate: (aValue, aOptions)->
    isFunction(aValue) or isFunctionStr(aValue)
