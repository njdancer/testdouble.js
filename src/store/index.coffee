_ = require('lodash')
EventEmitter = require('events').EventEmitter

storeEmitter = new EventEmitter()
globalStore = []

module.exports =
  onReset: (func) ->
    storeEmitter.on('reset', func)

  reset: ->
    globalStore = []
    storeEmitter.emit('reset')

  for: (testDouble, createIfNew = true) ->
    return entry if entry = _(globalStore).find({testDouble})
    return unless createIfNew
    _.tap initialEntryFor(testDouble), (newEntry) ->
      globalStore.push(newEntry)

initialEntryFor = (testDouble) ->
  {testDouble, stubbings: [], calls: [], verifications: []}

