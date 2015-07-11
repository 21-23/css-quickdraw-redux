ComponentViewModel   = require '../component.viewmodel'
PatternViewModel     = require '../pattern.viewmodel'
{nx} = require 'nexus'

describe 'ComponentViewModel', ->

	view_model = null
	data = ['this', 'is', 'test', 'data']

	beforeEach ->
		view_model = new ComponentViewModel data

	describe 'constructor', ->

		it 'saves incoming array to `patterns`', ->
			view_model.patterns.length.should.equal data.length
			view_model.patterns.every (pattern) -> pattern instanceof PatternViewModel
				.should.be.equal true

		it 'creates a nx.Cell property with empty string value', ->
			view_model.string.should.be.an.instanceof nx.Cell
			view_model.string.value.should.equal ''

	it 'should highlight matching templates', ->
		view_model.string.value = 'this data'
		view_model.patterns[0].is_matched.value.should.be.ok
		view_model.patterns[1].is_matched.value.should.be.ok
		view_model.patterns[2].is_matched.value.should.not.be.ok
		view_model.patterns[3].is_matched.value.should.be.ok

		view_model.string.value = 'data'
		view_model.patterns[0].is_matched.value.should.not.be.ok
		view_model.patterns[1].is_matched.value.should.not.be.ok
		view_model.patterns[2].is_matched.value.should.not.be.ok
		view_model.patterns[3].is_matched.value.should.be.ok
