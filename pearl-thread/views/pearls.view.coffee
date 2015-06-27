PearlView = require './pearl.view.coffee'

PearlsView = (context) ->
  require '../stylesheets/pearl-thread-style.styl'
  nxt.Element 'div',
    context.pearls.map (item) ->
      PearlView item

module.exports = PearlsView
