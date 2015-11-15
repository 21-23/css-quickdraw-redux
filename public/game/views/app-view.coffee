RoundPhase = require 'cssqd-shared/models/round-phase'

WaitScreenView = require '../views/wait-screen-view'

AppView = (context) ->
	nxt.Element 'div',
		nxt.Binding context.view, (phase) ->
			switch phase
				when RoundPhase.WAIT_SCREEN then WaitScreenView context

module.exports = AppView
