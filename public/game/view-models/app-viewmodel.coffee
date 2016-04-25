warp = require 'nexus-warp'
{nx} = require 'nexus'

Cascade = require 'cssqd-shared/nx/cascade'
RoundPhase = require 'cssqd-shared/models/round-phase'
SelectorMatchResult = require 'cssqd-shared/models/selector-match-result'

dateTimeFormats = (require 'common/utils/date-time-utils').formats

Round = require '../models/round'
MatchRenderer = require 'common/components/match-renderer'
OccurrenceIndicator = require 'common/components/occurrence-indicator'
UserPanelViewModel = (require 'common/components/user-panel').ViewModel
TimespanViewModel = (require 'common/components/timespan').ViewModel

class AppViewModel
	constructor: (sessionId) ->
		@SELECTOR_MAX_LENGTH = 128

		@user_data = new nx.Cell
		@game_session_id = new nx.Cell
		@round_phase = new nx.Cell
		@puzzle = new nx.Cell
		@countdown = new nx.Cell
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

		@matchRenderer = new MatchRenderer.ViewModel
		@matchRenderer.tag_list['<-'] @puzzle, ({tags}) -> tags
		@matchRenderer.match['<-'] @match

		@occurrenceIndicator = new OccurrenceIndicator.ViewModel
		@occurrenceIndicator.patterns['<-'] \
			@puzzle,
			({banned_characters}) -> banned_characters

		@occurrenceIndicator.string['<-'] @selector

		@userPanelViewModel = new UserPanelViewModel @user_data
		@roundTimerViewModel = new TimespanViewModel @countdown, dateTimeFormats['m:ss']
		@countdownViewModel = new TimespanViewModel @countdown, dateTimeFormats['s']

		@puzzle_solved = Cascade @round_phase, @match, (round_phase, match) ->
			round_phase is RoundPhase.IN_PROGRESS and match.result is SelectorMatchResult.POSITIVE

		@puzzle_solved['<-'] @round_phase, (round_phase) ->
			round_phase isnt RoundPhase.IN_PROGRESS

		#Keep session ID set as the last operation as it triggers the data flow
		@game_session_id.value = sessionId

module.exports = AppViewModel
