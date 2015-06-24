PearlViewModel = require '../view-models/pearl-viewmodel'
{nx} = require 'nexus'

describe 'PearlViewModel', ->

	view_model = null

	beforeEach ->
		view_model = new PearlViewModel

	it 'contains the `color` cell', ->
		view_model.color.should.be.an.instanceOf nx.Cell

	it 'contains the `text` cell', ->
		view_model.text.should.be.an.instanceOf nx.Cell

