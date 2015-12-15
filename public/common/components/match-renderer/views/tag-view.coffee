PuzzleTag = require 'dom-sandbox/models/puzzle/puzzle-tag'

AttrsView = require './attrs-view'

TagView = (tag, type = tag.type) ->
	elementBracket = if type is PuzzleTag.CLOSING then '</' else '<'

	nxt.Fragment [
		nxt.Element 'span',
			nxt.Class 'punctuator'
			nxt.Text elementBracket

		nxt.Element 'span',
			nxt.Class 'tagname'
			nxt.Text tag.element

		nxt.If type isnt PuzzleTag.CLOSING,
			AttrsView tag.attrs

		nxt.Element 'span',
			nxt.Class 'punctuator'
			nxt.Text '>'
	]

module.exports = TagView
