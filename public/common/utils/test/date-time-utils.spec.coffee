dateTtimeUtils = require '../date-time-utils'

describe 'dateTimeUtils', ->

	describe 'default time formatter', ->
		it 'formats the given value correctly', ->
			formatted = dateTtimeUtils.formatDefault 1000
			formatted.should.equal '1000'

			formatted = dateTtimeUtils.formatDefault 0
			formatted.should.equal '0'

			formatted = dateTtimeUtils.formatDefault -5
			formatted.should.equal '-5'

			formatted = dateTtimeUtils.formatDefault null
			formatted.should.equal ''

	describe 'single seconds only formatter', ->
		it 'formats the given value correctly', ->
			formatted = dateTtimeUtils.formatS 6000
			formatted.should.equal '6'

			formatted = dateTtimeUtils.formatS 14000
			formatted.should.equal '14'

			formatted = dateTtimeUtils.formatS 0
			formatted.should.equal '0'

			formatted = dateTtimeUtils.formatS -5
			formatted.should.equal '0'

			formatted = dateTtimeUtils.formatDefault undefined
			formatted.should.equal ''

	describe 'single minutes and seconds formatter', ->
		it 'formats the given value correctly', ->
			formatted = dateTtimeUtils.formatMSS 100000
			formatted.should.equal '1:40'

			formatted = dateTtimeUtils.formatMSS 198000
			formatted.should.equal '3:18'

			formatted = dateTtimeUtils.formatMSS 27000
			formatted.should.equal '0:27'

			formatted = dateTtimeUtils.formatMSS 242000
			formatted.should.equal '4:02'

			formatted = dateTtimeUtils.formatMSS 7000
			formatted.should.equal '0:07'

			formatted = dateTtimeUtils.formatDefault 'Smith'
			formatted.should.equal ''

			formatted = dateTtimeUtils.formatMSS 59000
			formatted.should.equal '0:59'

			formatted = dateTtimeUtils.formatMSS 60000
			formatted.should.equal '1:00'

			formatted = dateTtimeUtils.formatMSS 61000
			formatted.should.equal '1:01'
