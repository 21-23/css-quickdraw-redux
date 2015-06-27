PearlViewModel = require '../view-models/pearl-viewmodel'
{nx} = require 'nexus'

describe 'PearlViewModel', ->

	view_model = null
	pearl =
		color: 'white'
		text: '1'

	beforeEach ->
		view_model = new PearlViewModel pearl

	describe 'constructor', ->
		it 'sets cells\' values using passed parameters', ->
			view_model.color.value.should.equal pearl.color
			view_model.text.value.should.equal pearl.text

	it 'contains the `color` cell', ->
		view_model.color.should.be.an.instanceOf nx.Cell

	it 'contains the `text` cell', ->
		view_model.text.should.be.an.instanceOf nx.Cell
