PearlView = require './pearl.view.coffee'

PearlsView = (context) ->
  nxt.Element 'div',
    context.pearls.map PearlView

module.exports = PearlsView
