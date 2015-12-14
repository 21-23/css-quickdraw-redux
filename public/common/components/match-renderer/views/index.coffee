require 'common/stylesheets/match-renderer.styl'

PuzzleTag  = require 'dom-sandbox/models/puzzle/puzzle-tag'

IndentView = require './indent-view'
AttrsView  = require './attrs-view'
TagView    = require './tag-view'

MatchRendererView = (vm) ->
	indentSize = 1

	nxt.Element 'div',
		nxt.Class 'match-renderer'
		nxt.Binding vm.tags, (tags) ->
			nxt.Fragment tags.map (tag) ->
				if tag.type is PuzzleTag.CLOSING
					indentSize--

				commands = nxt.Element 'div',
					nxt.Class 'row'
					nxt.Binding tag.match, (match) ->
						if match
							nxt.Class if tag.objective then 'matched-positive' else 'matched-negative'
					IndentView indentSize
					TagView tag
					nxt.Text tag.text
					nxt.If tag.type is PuzzleTag.SINGLE_LINE,
						(TagView tag, PuzzleTag.CLOSING)

				if tag.type is PuzzleTag.OPENING
					indentSize++

				commands

module.exports = MatchRendererView
