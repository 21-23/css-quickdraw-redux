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
				{ node } = tag
				if node.type is PuzzleTag.CLOSING
					indentSize--

				commands = nxt.Element 'div',
					nxt.Class 'row'
					nxt.Binding tag.match, (match) ->
						if match
							nxt.Class if node.objective then '-matched-positive' else '-matched-negative'
					IndentView indentSize
					TagView node
					nxt.Text node.text
					nxt.If node.type is PuzzleTag.SINGLE_LINE,
						(TagView node, PuzzleTag.CLOSING)

				if node.type is PuzzleTag.OPENING
					indentSize++

				commands

module.exports = MatchRendererView
