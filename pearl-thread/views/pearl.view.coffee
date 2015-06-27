PearlView = (context) ->
  nxt.Element 'div',
    nxt.Binding context.text, nxt.Text
    nxt.Binding context.modifier, nxt.Class

module.exports = PearlView
