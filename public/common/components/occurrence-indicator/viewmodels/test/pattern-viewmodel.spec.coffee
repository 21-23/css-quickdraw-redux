PatternViewModel = require '../pattern.viewmodel.coffee'
{nx} = require 'nexus'

view_model = null
data = 'data'

beforeEach ->
	view_model = new PatternViewModel data

describe 'PatternViewModel', ->

	describe 'constructor', ->

		it 'sets pattern values using passed parameter', ->
			view_model.pattern.should.equal data

		it 'sets is_matched to `false` by default', ->
			view_model.is_matched.should.be.an.instanceOf nx.Cell
			view_model.is_matched.value.should.equal no
