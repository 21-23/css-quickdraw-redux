require '../styles/countdown-circle.styl'

TimespanView = (require '../../timespan').View

CountdownCircleView = (context) ->
	size = 2 * (context.circleOptions.radius + context.circleOptions.strokeWidth)

	nxt.Element 'div',
		nxt.Class 'countdown-circle'

		nxt.Element 'svg',
			nxt.Class 'circle-container'
			nxt.Attr 'width', size
			nxt.Attr 'height', size

			nxt.Element 'circle',
				nxt.Class 'circle-elapsed'
				nxt.Attr 'cx', "#{size / 2}"
				nxt.Attr 'cy', "#{size / 2}"
				nxt.Attr 'r', "#{context.circleOptions.radius}"
				nxt.Attr 'fill', 'none'
				nxt.Attr 'stroke-width', "#{context.circleOptions.strokeWidth - 1}"

			nxt.Element 'circle',
				nxt.Class 'circle-remaining'
				nxt.Attr 'cx', "#{size / 2}"
				nxt.Attr 'cy', "#{size / 2}"
				nxt.Attr 'r', "#{context.circleOptions.radius}"
				nxt.Attr 'fill', 'none'
				nxt.Attr 'stroke-width', "#{context.circleOptions.strokeWidth}"
				nxt.Style 'stroke-dasharray': context.dashArraySize
				nxt.Binding context.remainingCell, (remaining) ->
					remainingPercent = remaining / context.fullTime
					nxt.Style 'stroke-dashoffset': context.dashArraySize - Math.round remainingPercent * context.dashArraySize

		TimespanView context.timespanViewModel

module.exports = CountdownCircleView
