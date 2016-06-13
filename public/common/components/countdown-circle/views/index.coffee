require '../styles/countdown-circle.styl'

TimespanView = (require '../../timespan').View

CountdownCircleView = (context) ->
	size = 2 * (context.circleOptions.radius + context.circleOptions.strokeWidth)

	nxt.Element 'div',
		nxt.Class 'countdown-circle'
		nxt.Class context.circleOptions.countdownCssClass
		nxt.Style 'width': "#{size}px", 'height': "#{size}px"

		nxt.SvgElement 'svg',
			nxt.Class 'circle-container'
			nxt.Attr
				'width': size
				'height': size

			nxt.SvgElement 'circle',
				nxt.Class 'circle-elapsed'
				nxt.Attr
					'cx': "#{size / 2}"
					'cy': "#{size / 2}"
					'r': "#{context.circleOptions.radius}"
					'fill': 'none'
					'stroke-width': "#{context.circleOptions.strokeWidth - 1}"

			nxt.SvgElement 'circle',
				nxt.Class 'circle-remaining'
				nxt.Attr
					'cx': "#{size / 2}"
					'cy': "#{size / 2}"
					'r': "#{context.circleOptions.radius}"
					'fill': 'none'
					'stroke-width': "#{context.circleOptions.strokeWidth}"
					'stroke-linecap': 'round'
					'stroke-dasharray': context.dashArraySize
				nxt.Binding context.remainingCell, (remaining) ->
					correctedRemaining = if remaining > 0 then (remaining - context.shear) else 0
					remainingPercent = correctedRemaining / context.fullTime.value
					nxt.Style 'stroke-dashoffset': context.dashArraySize - Math.round remainingPercent * context.dashArraySize

		TimespanView context.timespanViewModel

module.exports = CountdownCircleView
