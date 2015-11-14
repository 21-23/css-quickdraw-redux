{nx} = require 'nexus-node'

class Countdown

	constructor: ->

		ONE_SECOND = 1000
		@_interval = null

		interval_handler = =>
			@remaining.value -= ONE_SECOND
			if @remaining.value is 0
				@active.value = no
				@timeout.value = yes

		@time = new nx.Cell

		@remaining = new nx.Cell
			'<-': [@time]

		@active = new nx.Cell
			value: no
			action: (value) =>
				clearInterval @_interval
				if value
					@_interval = setInterval interval_handler, ONE_SECOND

		@timeout = new nx.Cell

module.exports = Countdown
