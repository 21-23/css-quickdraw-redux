TimespanView = (require 'common/components/timespan').View

GameView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-countdown'
		TimespanView context.countdownViewModel

module.exports = GameView
