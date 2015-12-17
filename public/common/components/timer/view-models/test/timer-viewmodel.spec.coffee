TimerViewModel = require '../timer.viewmodel'
{ nx } = require 'nexus'

describe 'TimerViewModel', ->

	describe 'contructor', ->
		it 'selects the formatter correctly', ->
			model = new TimerViewModel new nx.Cell(value: 1000), TimerViewModel.formats['s']
			model.remaining.value.should.equal '1'

			model = new TimerViewModel new nx.Cell(value: 1000), TimerViewModel.formats['m:ss']
			model.remaining.value.should.equal '0:01'

			model = new TimerViewModel new nx.Cell(value: 1000), null
			model.remaining.value.should.equal '1000'

	describe 'default time formatter', ->
		it 'formats the given value correctly', ->
			formatted = TimerViewModel.prototype.formatDefault 1000
			formatted.should.equal '1000'

			formatted = TimerViewModel.prototype.formatDefault 0
			formatted.should.equal '0'

			formatted = TimerViewModel.prototype.formatDefault -5
			formatted.should.equal '-5'

			formatted = TimerViewModel.prototype.formatDefault null
			formatted.should.equal ''

	describe 'single seconds only formatter', ->
		it 'formats the given value correctly', ->
			formatted = TimerViewModel.prototype.formatS 6000
			formatted.should.equal '6'

			formatted = TimerViewModel.prototype.formatS 14000
			formatted.should.equal '14'

			formatted = TimerViewModel.prototype.formatS 0
			formatted.should.equal '0'

			formatted = TimerViewModel.prototype.formatS -5
			formatted.should.equal '0'

			formatted = TimerViewModel.prototype.formatDefault undefined
			formatted.should.equal ''

	describe 'single minutes and seconds formatter', ->
		it 'formats the given value correctly', ->
			formatted = TimerViewModel.prototype.formatMSS 100000
			formatted.should.equal '1:40'

			formatted = TimerViewModel.prototype.formatMSS 198000
			formatted.should.equal '3:18'

			formatted = TimerViewModel.prototype.formatMSS 27000
			formatted.should.equal '0:27'

			formatted = TimerViewModel.prototype.formatMSS 242000
			formatted.should.equal '4:02'

			formatted = TimerViewModel.prototype.formatMSS 7000
			formatted.should.equal '0:07'

			formatted = TimerViewModel.prototype.formatDefault 'Smith'
			formatted.should.equal ''

			formatted = TimerViewModel.prototype.formatMSS 59000
			formatted.should.equal '0:59'

			formatted = TimerViewModel.prototype.formatMSS 60000
			formatted.should.equal '1:00'

			formatted = TimerViewModel.prototype.formatMSS 61000
			formatted.should.equal '1:01'
