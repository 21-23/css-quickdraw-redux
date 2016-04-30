TimespanViewModel = (require '../../timespan').ViewModel

class CountdownCircle
	constructor: (@remainingCell, @fullTime, format, @circleOptions) ->
		@timespanViewModel = new TimespanViewModel @remainingCell, format

		@dashArraySize = Math.round 2 * Math.PI * @circleOptions.radius

module.exports = CountdownCircle
