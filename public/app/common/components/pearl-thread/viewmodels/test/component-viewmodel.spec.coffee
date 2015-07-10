PearlViewModel     = require '../pearl-viewmodel'
ComponentViewModel = require '../component-viewmodel'
{nx} = require 'nexus'

describe 'ComponentViewModel', ->

	view_model = null
	data = [1, 2, 3]

	beforeEach ->
		view_model = new ComponentViewModel data

	describe 'constructor', ->

		it 'saves an array of PearlViewModel instances to `pearls`', ->
			view_model.pearls.length.should.equal data.length
			view_model.pearls.every (pearl) -> pearl instanceof PearlViewModel
				.should.be.equal true

		it 'uses custom view model if its constructor is passed as the second argument', ->
			FakePearlViewModel = ->
			view_model = new ComponentViewModel data, FakePearlViewModel
			view_model.pearls.every (pearl) -> pearl instanceof FakePearlViewModel
				.should.be.equal true
