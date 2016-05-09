RoundPhase = require 'cssqd-shared/models/round-phase'

WaitScreenView   = require '../views/wait-screen-view'
CountdownView    = require '../views/countdown-view'
GameView         = require '../views/game-view'
DisconnectedView = require '../views/disconnected-view'

AppView = (context) ->
	nxt.Element 'div',
		nxt.Binding context.view, (phase) ->
			switch phase
				when RoundPhase.WAIT_SCREEN then WaitScreenView context
				when RoundPhase.COUNTDOWN then CountdownView context
				when RoundPhase.IN_PROGRESS then GameView context
				when RoundPhase.FINISHED then WaitScreenView context
				when RoundPhase.DISCONNECTED then DisconnectedView context

module.exports = AppView
