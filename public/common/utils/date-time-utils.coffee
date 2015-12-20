{ isNumeric } = require './data-type-utils'

module.exports = {
	formats: {
		's'
		'm:ss'
	}

	#yes, I know that there should be a super-duper format fucntion
	#but now we need only 2 formats
	#or even 2 static functions

	formatDefault: (value) ->
		if isNumeric value
			'' + value
		else
			''

	formatS: (value) ->
		if isNumeric(value)
			'' + ((value / 1000) | 0)
		else
			''

	formatMSS: (value) ->
		return '' if not isNumeric value

		seconds = (value / 1000) | 0

		minutes = if seconds >= 60 then (seconds / 60) | 0 else 0
		seconds = seconds - (60 * minutes)
		seconds = '0' + seconds if seconds < 10

		"#{minutes}:#{seconds}"
}
