inherits        = require 'inherits-ex/lib/inherits'
Value           = require 'abstract-type/value'
isObject        = require 'util-ex/lib/is/type/object'
extend          = require 'util-ex/lib/_extend'

module.exports = class FunctionValue
  inherits FunctionValue, Value

  _toObject: (aOptions)->
    result  = @valueOf()
    if isObject result.scope
      vScope  = extend {}, result.scope
      vGlobal = @$type.global
      vGlobal.toName vScope if vGlobal
      result = function: String(result), scope: vScope
    else
      result = String(result)
    result
