class GameSessionCommand

	@START_ROUND: 'start_round'
	@END_ROUND:   'end_round'

	constructor: (@action, @data) ->

module.exports = GameSessionCommand
