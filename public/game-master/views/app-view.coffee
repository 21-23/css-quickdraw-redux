UserPanelView = (require 'common/components/user-panel').View
CountdownCircleView     = (require 'common/components/countdown-circle').View
ButtonView = (require 'common/components/button').View
GameControlButtonView = (require 'common/components/game-control-button').View
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

				nxt.Binding context.puzzles, (puzzles) ->
					nxt.Element 'div',
						nxt.Class 'qd-pearl-thread'
						puzzles?.map (puzzle, index) ->
							nxt.Element 'div',
								nxt.Text puzzle.name
								nxt.Event 'click', context.current_puzzle_index, -> index

				nxt.Element 'div',
					nxt.Class 'game-master-screen-columns'

					nxt.Element 'div',
						nxt.Class 'controls-column'

						nxt.Element 'div',
							nxt.Class 'level-control-info'

							nxt.Element 'div',
								nxt.Class 'level-controls'

								nxt.Element 'p',
									nxt.Class 'levels-info-num'
									nxt.Binding context.current_puzzle_index, (index) ->
										nxt.Text "Level #{index + 1}:"

								nxt.Element 'p',
									nxt.Class 'levels-info-name'
									nxt.Binding context.current_puzzle, (puzzle) -> nxt.Text puzzle?.name or "Puzzle #{puzzle?.index}"

								GameControlButtonView context.gameControlButtonViewModel

							CountdownCircleView context.roundTimerViewModel

						nxt.Element 'div',
							nxt.Class 'master-controls-solution-container'

							nxt.Element 'div',
								nxt.Class 'solution-container'
								nxt.Text 'Solution: '
								nxt.Element 'span',
									nxt.Class 'solution-value'
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
						nxt.Class 'user-list-column'

						nxt.Binding context.round_phase, (phase) ->
							if phase is RoundPhase.FINISHED
								nxt.Element 'div',
									nxt.Class 'aggregate-score'

									nxt.Element 'div',
										nxt.Class 'header'
										nxt.Element 'div',
											nxt.Class '-name'
											nxt.Text 'Player Name'
										nxt.Element 'div',
											nxt.Class '-time'
											nxt.Text 'Time'

									nxt.Binding context.aggregate_score, (scores = []) ->
										nxt.Fragment scores.map ({name, score}, rating) ->
											nxt.Element 'div',
												nxt.Class 'aggregate-score-item'
												nxt.Element 'div',
													nxt.Class 'aggregate-score-player-name'
													nxt.Text "#{name}"
												nxt.Element 'div',
													nxt.Class 'aggregate-score-player-score'
													nxt.Text "#{formatMSS score}"
							else
								PlayersListView context.playersListViewModel

			nxt.Element 'div',
				nxt.Class 'master-controls-container'

				nxt.Element 'div',
					nxt.Class 'master-controls'

					nxt.Element 'div',
						nxt.Class 'master-controls-gameplay'

						ButtonView context.StartButtonViewModel
						ButtonView context.StopButtonViewModel
						ButtonView context.NextButtonViewModel

		nxt.Element 'div',
			nxt.Binding context.current_puzzle_index, nxt.Text

module.exports = AppView
