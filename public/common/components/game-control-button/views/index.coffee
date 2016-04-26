require '../styles/game-control-button.styl'
RoundPhase = require 'cssqd-shared/models/round-phase'

GameControlButtonView = (context) ->
	nxt.Element 'a',
		nxt.Class 'game-control-button'
		nxt.Attr 'href', '#'
		nxt.Event 'click', context.click
		nxt.Binding context.round_phase, nxt.Class
		nxt.Binding context.round_phase, (roundPhase) ->
			text = if roundPhase is RoundPhase.IN_PROGRESS then 'STOP LEVEL' else 'NEXT LEVEL'
			nxt.Text text

module.exports = GameControlButtonView
