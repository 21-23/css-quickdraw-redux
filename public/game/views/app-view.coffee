RoundPhase = require 'cssqd-shared/models/round-phase'

WaitScreenView = require '../views/wait-screen-view'
GameView       = require '../views/game-view'

AppView = (context) ->
	nxt.Element 'div',
		nxt.Binding context.view, (phase) ->
			switch phase
				when RoundPhase.WAIT_SCREEN then WaitScreenView context
				when RoundPhase.IN_PROGRESS then GameView context

module.exports = AppView