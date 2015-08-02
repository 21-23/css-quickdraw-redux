require 'normalize.css'
require './landing.styl'

document.addEventListener 'DOMContentLoaded', ->
	initHideOnScroll 150
	initScrollDownArrows 1000

initHideOnScroll = (scrollLimit) ->
	hideOnScrollNodes = document.getElementsByClassName '-hide-during-scroll'
	lastOpacity = 1

	window.addEventListener 'scroll', ->
		currentScroll = @pageYOffset
		newOpacity = 1
		i = 0

		newOpacity = 1 - currentScroll / scrollLimit
		newOpacity = 0 if newOpacity < 0

		return if newOpacity is lastOpacity

		for node in hideOnScrollNodes
			node.style.opacity = newOpacity

		lastOpacity = newOpacity

initScrollDownArrows = (scrollDuration) ->
	[arrows] = document.getElementsByClassName 'scroll-down-container'
	currentPosition = window.scrollY
	targetPosition = window.innerHeight
	scrollLength = targetPosition - currentPosition
	frameStart = null

	scrollStep = (timeStamp) ->
		if not frameStart
			frameStart = timeStamp

		currentPosition += (timeStamp - frameStart) / 10 / scrollDuration * scrollLength
		currentPosition = targetPosition if currentPosition > targetPosition

		window.scrollTo 0, currentPosition

		if currentPosition < targetPosition
			window.requestAnimationFrame scrollStep

	if arrows
		arrows.addEventListener 'click', ->
			currentPosition = window.scrollY
			targetPosition = window.innerHeight
			scrollLength = Math.min targetPosition - currentPosition, document.body.scrollHeight - targetPosition
			frameStart = null

			if scrollLength > 0
				window.requestAnimationFrame scrollStep
