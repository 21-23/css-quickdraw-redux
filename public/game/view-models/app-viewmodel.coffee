warp = require 'nexus-warp'
{nx} = require 'nexus'

Cascade = require 'cssqd-shared/nx/cascade'
RoundPhase = require 'cssqd-shared/models/round-phase'
{ COUNTDOWN_TIMER_STEP } = require 'cssqd-shared/constants'
SelectorMatchResult = require 'cssqd-shared/models/selector-match-result'

dateTimeFormats = (require 'common/utils/date-time-utils').formats

Round = require '../models/round'
MatchRenderer = require 'common/components/match-renderer'
OccurrenceIndicator = require 'common/components/occurrence-indicator'
UserPanelViewModel = (require 'common/components/user-panel').ViewModel
TimespanViewModel = (require 'common/components/timespan').ViewModel
CountdownCircleViewModel = (require 'common/components/countdown-circle').ViewModel
ButtonViewModel = (require 'common/components/button').ViewModel

class AppViewModel
	constructor: (sessionId) ->
		@SELECTOR_MAX_LENGTH = 128

		@user_data = new nx.Cell
		@game_session_id = new nx.Cell
		@round_phase = new nx.Cell
		@puzzle = new nx.Cell
		@countdown = new nx.Cell
		@currentRoundTimeLimit = new nx.Cell
		@role = new nx.Cell

		@selector = new nx.Cell
		@match = new nx.Cell

		@view = new nx.Cell
			'<-': [
					@round_phase,
					# convert phase to view alias; for now - 1-to-1 conversion
					nx.Identity
				]

		@warp_client = new warp.Client
			transport: new warp.WebSocketTransport address:"ws://#{window.location.host}"
			entities:
				user_data:       @user_data
				game_session_id: @game_session_id
				round_phase:     @round_phase
				puzzle:          @puzzle
				countdown:       @countdown
				role:            @role

				selector: @selector
				match:    @match

		@listenToConnectionClose @warp_client.transport

		@matchRenderer = new MatchRenderer.ViewModel
		@matchRenderer.tag_list['<-'] @puzzle, ({tags}) -> tags
		@matchRenderer.match['<-'] @match

		@occurrenceIndicator = new OccurrenceIndicator.ViewModel
		@occurrenceIndicator.patterns['<-'] \
			@puzzle,
			({banned_characters}) -> banned_characters

		@occurrenceIndicator.string['<-'] @selector

		@userPanelViewModel = new UserPanelViewModel @user_data

		@currentRoundTimeLimit['<-'] @puzzle, (puzzle) -> puzzle.time_limit
		@roundTimerViewModel = new CountdownCircleViewModel @countdown,
			@currentRoundTimeLimit
			COUNTDOWN_TIMER_STEP
			dateTimeFormats['m:ss']
			{ radius: 40, strokeWidth: 5 }
		@countdownViewModel = new TimespanViewModel @countdown, dateTimeFormats['s']

		@puzzle_solved = Cascade @round_phase, @match, (round_phase, match) ->
			round_phase is RoundPhase.IN_PROGRESS and match.result is SelectorMatchResult.POSITIVE

		@puzzle_solved['<-'] @round_phase, (round_phase) ->
			round_phase isnt RoundPhase.IN_PROGRESS

		@RefreshButtonViewModel = new ButtonViewModel ''
		@RefreshButtonViewModel.click.onvalue.add ->
			do window.location.reload

		#Keep session ID set as the last operation as it triggers the data flow
		@game_session_id.value = sessionId

	listenToConnectionClose: (transport) ->
		if transport.socket
			transport.socket.onclose = (event) =>
				#check event.code https://developer.mozilla.org/en-US/docs/Web/API/CloseEvent ?
				@view.value = RoundPhase.DISCONNECTED


module.exports = AppViewModel
