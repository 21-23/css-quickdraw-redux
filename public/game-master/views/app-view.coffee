UserPanelView = (require 'common/components/user-panel').View
TimespanView = (require 'common/components/timespan').View
ButtonView = (require 'common/components/button').View
PlayersListView = (require 'common/components/players-list').View
MatchRendererView       = (require 'common/components/match-renderer').View
OccurrenceIndicatorView = (require 'common/components/occurrence-indicator').View

{ formatMSS } = (require '../../common/utils/date-time-utils')

RoundPhase = require 'cssqd-shared/models/round-phase'

AppView = (context) ->
	nxt.Element 'div',
		nxt.Class 'game-master-screen'

		UserPanelView context.userPanelViewModel

		nxt.Element 'div',
			nxt.Class 'game-master-screen-container'

				nxt.Element 'input',
					nxt.Attr 'readonly', 'readonly'
					nxt.Class 'client-url'
					nxt.Event 'focus', -> do @select
					nxt.Binding context.game_session_id, (sessionId) ->
						nxt.Attr 'value', "#{location.origin}/game.html?id=#{sessionId}"

				nxt.Binding context.puzzles, (puzzles) ->
					nxt.Element 'div',
						nxt.Class 'qd-pearl-thread'
						puzzles?.map (puzzle, index) ->
							nxt.Element 'div',
								nxt.Text puzzle.name
								nxt.Event 'click', context.current_puzzle_index, -> index

			nxt.Element 'div',
				nxt.Class 'master-controls-container'

				nxt.Element 'div',
					nxt.Class 'players-list'
					PlayersListView context.playersListViewModel
					nxt.Binding context.round_phase, (phase) ->
						if phase is RoundPhase.FINISHED
							nxt.Element 'div',
								nxt.Binding context.aggregate_score, (scores = []) ->
									nxt.Fragment scores.map ({name, score}) ->
										nxt.Element 'div',
											nxt.Text "#{name} #{formatMSS score}"

				nxt.Element 'div',
					nxt.Class 'master-controls'

					nxt.Element 'div',
						nxt.Class 'master-controls-timings'

						nxt.Element 'div',
							nxt.Class 'round-title'
							nxt.Binding context.current_puzzle, (puzzle) -> nxt.Text puzzle?.name
						TimespanView context.remainingTimeViewModel

					nxt.Element 'div',
						nxt.Class 'master-controls-gameplay'

						ButtonView context.StartButtonViewModel
						ButtonView context.StopButtonViewModel
						ButtonView context.NextButtonViewModel

					nxt.Element 'div',
						nxt.Class 'master-controls-solution-container'

						nxt.Element 'span',
							nxt.Text 'Solution: '
						nxt.Element 'span',
							nxt.Binding context.current_puzzle_visible_soultion, nxt.Text

					nxt.Element 'div',
						nxt.Class 'controls-selector-banned-container'
						nxt.Text 'Banned chars'
						nxt.Binding context.round_phase, (phase) ->
							#should we each time re-create MatchRenderer? or use CSS to show/hide?
							if phase is RoundPhase.FINISHED or phase is RoundPhase.IN_PROGRESS
								OccurrenceIndicatorView context.occurrenceIndicator

					nxt.Binding context.round_phase, (phase) ->
						#should we each time re-create MatchRenderer? or use CSS to show/hide?
						if phase is RoundPhase.FINISHED or phase is RoundPhase.IN_PROGRESS
							MatchRendererView context.matchRenderer

		nxt.Element 'div',
			nxt.Binding context.current_puzzle_index, nxt.Text

module.exports = AppView
