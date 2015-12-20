TimespanViewModel = require '../timespan.viewmodel'
{ nx } = require 'nexus'

describe 'TimespanViewModel', ->

	describe 'contructor', ->
		it 'selects the formatter correctly', ->
			model = new TimespanViewModel new nx.Cell(value: 1000), TimespanViewModel.formats['s']
			model.remaining.value.should.equal '1'

			model = new TimespanViewModel new nx.Cell(value: 1000), TimespanViewModel.formats['m:ss']
			model.remaining.value.should.equal '0:01'

			model = new TimespanViewModel new nx.Cell(value: 1000), null
			model.remaining.value.should.equal '1000'

	describe 'default time formatter', ->
		it 'formats the given value correctly', ->
			formatted = TimespanViewModel.prototype.formatDefault 1000
			formatted.should.equal '1000'

			formatted = TimespanViewModel.prototype.formatDefault 0
			formatted.should.equal '0'

			formatted = TimespanViewModel.prototype.formatDefault -5
			formatted.should.equal '-5'

			formatted = TimespanViewModel.prototype.formatDefault null
			formatted.should.equal ''

	describe 'single seconds only formatter', ->
		it 'formats the given value correctly', ->
			formatted = TimespanViewModel.prototype.formatS 6000
			formatted.should.equal '6'

			formatted = TimespanViewModel.prototype.formatS 14000
			formatted.should.equal '14'

			formatted = TimespanViewModel.prototype.formatS 0
			formatted.should.equal '0'

			formatted = TimespanViewModel.prototype.formatS -5
			formatted.should.equal '0'

			formatted = TimespanViewModel.prototype.formatDefault undefined
			formatted.should.equal ''

	describe 'single minutes and seconds formatter', ->
		it 'formats the given value correctly', ->
			formatted = TimespanViewModel.prototype.formatMSS 100000
			formatted.should.equal '1:40'

			formatted = TimespanViewModel.prototype.formatMSS 198000
			formatted.should.equal '3:18'

			formatted = TimespanViewModel.prototype.formatMSS 27000
			formatted.should.equal '0:27'

			formatted = TimespanViewModel.prototype.formatMSS 242000
			formatted.should.equal '4:02'

			formatted = TimespanViewModel.prototype.formatMSS 7000
			formatted.should.equal '0:07'

			formatted = TimespanViewModel.prototype.formatDefault 'Smith'
			formatted.should.equal ''

			formatted = TimespanViewModel.prototype.formatMSS 59000
			formatted.should.equal '0:59'

			formatted = TimespanViewModel.prototype.formatMSS 60000
			formatted.should.equal '1:00'

			formatted = TimespanViewModel.prototype.formatMSS 61000
			formatted.should.equal '1:01'
