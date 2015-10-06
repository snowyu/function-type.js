## function-type [![npm][npm-svg]][npm]

[![Build Status][travis-svg]][travis]
[![Code Climate][codeclimate-svg]][codeclimate]
[![Test Coverage][codeclimate-test-svg]][codeclimate-test]
[![downloads][npm-download-svg]][npm]
[![license][npm-license-svg]][npm]

[npm]: https://npmjs.org/package/function-type
[npm-svg]: https://img.shields.io/npm/v/function-type.svg
[npm-download-svg]: https://img.shields.io/npm/dm/function-type.svg
[npm-license-svg]: https://img.shields.io/npm/l/function-type.svg
[travis-svg]: https://img.shields.io/travis/snowyu/function-type.js/master.svg
[travis]: http://travis-ci.org/snowyu/function-type.js
[codeclimate-svg]: https://codeclimate.com/github/snowyu/function-type.js/badges/gpa.svg
[codeclimate]: https://codeclimate.com/github/snowyu/function-type.js
[codeclimate-test-svg]: https://codeclimate.com/github/snowyu/function-type.js/badges/coverage.svg
[codeclimate-test]: https://codeclimate.com/github/snowyu/function-type.js/coverage

The function type object.

* The function type could have a `globalScope` and `global` object.
  * the `global` object can not be exported. used to expose the functions.
  * the `globalScope` object can be exported.
* the function value could have `scope` object.
  * the `scope` object can be exported.

the `globalScope` and `scope` can specify the `global` function to use.
It must be enclosed in '\`'.

## Usage

```js
var FunctionType  = require('function-type')
var Func = FunctionType({
  globalScope:{
    hi: 'hi '
    , echo: '`echo`'
    , log: '`log`'
  }
  , global: {
      echo: function(a){return a}
    , log: console.log
  }
})
var f = Func.create('function print(a){log(hi+title+a)}', {scope:{title:'myTest:'}})
f.valueOf()('123')
//='hi myTest:123'

```

## API

See [abstract-type](https://github.com/snowyu/abstract-type.js).

## TODO


## License

MIT
