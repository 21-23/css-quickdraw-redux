ComponentViewModel   = require '../component.viewmodel'
PatternViewModel     = require '../pattern.viewmodel'
{nx} = require 'nexus'

describe 'ComponentViewModel', ->

	view_model = null
	data = ['this', 'is', 'test', 'data']

	beforeEach ->
		view_model = new ComponentViewModel
		view_model.patterns.value = data

	describe 'constructor', ->

		it 'creates an nx.Cell property with empty string value', ->
			view_model.string.should.be.an.instanceof nx.Cell
			view_model.string.value.should.equal ''

	describe 'patterns', ->

		it 'transforms an array of string patterns into array of VMs', ->
			view_model.items.value.length.should.equal data.length
			view_model.items.value.every (item) -> item instanceof PatternViewModel
				.should.equal yes

	it 'updates the is_matched cell for every pattern', ->
		view_model.string.value = 'this data'
		view_model.items.value.map ({is_matched}) -> is_matched.value
			.should.deep.equal [yes, yes, no, yes]

		view_model.string.value = 'data'
		view_model.items.value.map ({is_matched}) -> is_matched.value
			.should.deep.equal [no, no, no, yes]
