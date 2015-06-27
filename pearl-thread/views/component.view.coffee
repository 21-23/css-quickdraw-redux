PearlView = require './pearl.view.coffee'

PearlsView = (context) ->
  nxt.Element 'div',
    context.pearls.map (item) ->
      PearlView item

module.exports = PearlsView
