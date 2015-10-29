{nx} = require 'nexus-node'

class Matcher

	constructor: ->
		@selector = new nx.Cell
		@puzzle = new nx.Cell
		@match = new nx.Cell

module.exports = Matcher
