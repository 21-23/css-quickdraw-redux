{nx} = require 'nexus'

class PearlViewModel

	constructor: ->
		@color = new nx.Cell
		@text = new nx.Cell

module.exports = PearlViewModel
