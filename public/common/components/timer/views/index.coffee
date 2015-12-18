require '../styles/timer.styl'

TimerView = (context) ->
	nxt.Element 'div',
		nxt.Class 'timer'
		nxt.Binding context.remaining, nxt.Text

module.exports = TimerView
