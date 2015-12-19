require '../styles/timespan.styl'

TimespanView = (context) ->
	nxt.Element 'div',
		nxt.Class 'timespan'
		nxt.Binding context.remaining, nxt.Text

module.exports = TimespanView
