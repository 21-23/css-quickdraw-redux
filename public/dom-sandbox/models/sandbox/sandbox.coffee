{nx} = require 'nexus'

class Sandbox

	constructor: ->
		@puzzle = new nx.Cell
		@selector = new nx.Cell
		@match = new nx.Cell

module.exports = Sandbox
