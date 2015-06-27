PearlView = (context) ->
  nxt.Element 'div',
    nxt.Binding context.text, nxt.Text

module.exports = PearlView
