PearlView = (context) ->
  nxt.Element 'div',
    nxt.Binding context.text, nxt.Text
    nxt.Binding context.color, (color) ->
      nxt.Style 'background': color

module.exports = PearlView
