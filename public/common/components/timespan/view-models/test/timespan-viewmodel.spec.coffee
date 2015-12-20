TimespanViewModel = require '../timespan.viewmodel'
dateTimeUtils = require '../../../../utils/date-time-utils'
{ nx } = require 'nexus'

describe 'TimespanViewModel', ->

	describe 'contructor', ->
		it 'selects the formatter correctly', ->
			model = new TimespanViewModel new nx.Cell(value: 1000), dateTimeUtils.formats['s']
			model.remaining.value.should.equal '1'

			model = new TimespanViewModel new nx.Cell(value: 1000), dateTimeUtils.formats['m:ss']
			model.remaining.value.should.equal '0:01'

			model = new TimespanViewModel new nx.Cell(value: 1000), null
			model.remaining.value.should.equal '1000'
