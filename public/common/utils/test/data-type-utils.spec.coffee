dataTypeUtils = require '../data-type-utils'

describe 'dataTypeUtils', ->

	describe 'isNumeric', ->

		it 'determines numbers correctly', ->
			dataTypeUtils.isNumeric(1).should.equal yes
			dataTypeUtils.isNumeric(-5).should.equal yes
			dataTypeUtils.isNumeric(0).should.equal yes

			dataTypeUtils.isNumeric(null).should.equal no
			dataTypeUtils.isNumeric().should.equal no
			dataTypeUtils.isNumeric('John').should.equal no
