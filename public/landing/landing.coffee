require 'normalize.css'
require './landing.styl'

document.addEventListener 'DOMContentLoaded', ->
	initHideOnScroll 150

initHideOnScroll = (scrollLimit) ->
	hideOnScrollNodes = document.getElementsByClassName '-hide-during-scroll'
	lastOpacity = 1

	window.addEventListener 'scroll', ->
		currentScroll = this.pageYOffset
		newOpacity = 1
		i = 0

		newOpacity = 1 - currentScroll / scrollLimit
		if newOpacity < 0
			newOpacity = 0

		if newOpacity is lastOpacity
			return

		for node in hideOnScrollNodes
			do (node) ->
				node.style.opacity = newOpacity

		lastOpacity = newOpacity
	, false
