PatternViewModel = require '../pattern.viewmodel.coffee'
{nx} = require 'nexus'

view_model = null
data = 'data'
test_cell = new nx.Cell value: ''

beforeEach ->
	view_model = new PatternViewModel data, test_cell

describe 'PatternViewModel', ->

	describe 'constructor', ->
		it 'sets values using passed parameters', ->
			view_model.pattern.should.equal data
			view_model.is_matched.should.be.an.instanceOf nx.Cell
			view_model.is_matched.value.should.not.be.ok

	it 'should binding is_matched property with passed nx.Cell', ->
		test_cell.value = 'it contains data'
		view_model.is_matched.should.be.ok
		test_cell.value = 'it contains somthing else'
		view_model.is_matched.should.not.be.ok
