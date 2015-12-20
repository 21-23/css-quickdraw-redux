{ isNumeric } = require '../../../utils/data-type-utils'
dateTimeUtils = require '../../../utils/date-time-utils'

class TimespanViewModel
	constructor: (remainingCell, format) ->
		@remaining = new nx.Cell
			'<<-': [ remainingCell, @selectFormatter(format) ]

	selectFormatter: (format) ->
		#there could be a super-duper DataTime formatter but not now
		switch format
			when dateTimeUtils.formats['s'] then dateTimeUtils.formatS
			when dateTimeUtils.formats['m:ss'] then dateTimeUtils.formatMSS
			else dateTimeUtils.formatDefault

module.exports = TimespanViewModel
