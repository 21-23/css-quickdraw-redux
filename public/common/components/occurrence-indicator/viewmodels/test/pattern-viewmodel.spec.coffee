PatternViewModel = require '../pattern.viewmodel.coffee'
{nx} = require 'nexus'

view_model = null
test_cell = null
data = 'data'

beforeEach ->
	test_cell = new nx.Cell
	view_model = new PatternViewModel data, test_cell

describe 'PatternViewModel', ->

	describe 'constructor', ->

		it 'sets pattern values using passed parameter', ->
			test_cell.value = ''
			view_model.pattern.should.equal data

		it 'sets string values using passed parameter', ->
			test_cell.value = ''
			view_model.is_matched.should.be.an.instanceOf nx.Cell
			view_model.is_matched.value.should.equal no

	it 'should bind is_matched property with passed nx.Cell', ->
		test_cell.value = 'it contains data'
		view_model.is_matched.value.should.equal yes

		test_cell.value = 'it contains somthing else'
		view_model.is_matched.value.should.equal no
