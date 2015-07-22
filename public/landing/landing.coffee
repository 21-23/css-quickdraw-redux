require 'normalize.css'
require './landing.styl'

document.addEventListener 'DOMContentLoaded', ->
	initHideOnScroll 150

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
