TimerView = (require 'common/components/timer').View

GameView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-countdown'
		TimerView context.countdownViewModel

module.exports = GameView
