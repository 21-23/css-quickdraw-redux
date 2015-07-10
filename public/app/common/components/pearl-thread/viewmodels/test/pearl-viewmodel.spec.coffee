PearlViewModel = require '../pearl-viewmodel'
{nx} = require 'nexus'

describe 'PearlViewModel', ->

	view_model = null
	pearl =
		modifier: '-bright'
		text: '1'

	beforeEach ->
		view_model = new PearlViewModel pearl

	describe 'constructor', ->
		it 'sets cells\' values using passed parameters', ->
			view_model.modifier.value.should.equal pearl.modifier
			view_model.text.value.should.equal pearl.text

	it 'contains the `color` cell', ->
		view_model.modifier.should.be.an.instanceOf nx.Cell

	it 'contains the `text` cell', ->
		view_model.text.should.be.an.instanceOf nx.Cell
