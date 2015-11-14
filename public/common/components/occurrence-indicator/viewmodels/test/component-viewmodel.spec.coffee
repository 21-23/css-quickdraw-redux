ComponentViewModel   = require '../component.viewmodel'
PatternViewModel     = require '../pattern.viewmodel'
{nx} = require 'nexus'

describe 'ComponentViewModel', ->

	view_model = null
	data = ['this', 'is', 'test', 'data']

	beforeEach ->
		view_model = new ComponentViewModel data

	describe 'constructor', ->

		it 'saves passed array to `patterns`', ->
			view_model.patterns.length.should.equal data.length
			view_model.patterns.every (pattern) -> pattern instanceof PatternViewModel
				.should.equal yes

		it 'creates an nx.Cell property with empty string value', ->
			view_model.string.should.be.an.instanceof nx.Cell
			view_model.string.value.should.equal ''

	it 'updates the is_matched cell for every pattern', ->
		view_model.string.value = 'this data'
		view_model.patterns.map ({is_matched}) -> is_matched.value
			.should.deep.equal [yes, yes, no, yes]

		view_model.string.value = 'data'
		view_model.patterns.map ({is_matched}) -> is_matched.value
			.should.deep.equal [no, no, no, yes]
