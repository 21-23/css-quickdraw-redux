PuzzleTag           = require './puzzle-tag'
SelectorMatchResult = require './selector-match-result'

class Puzzle

	@create_fragment: (html) ->
		document
			.createRange()
			.createContextualFragment html

	@create_tag_item: (node, type) ->
		unless node.nodeType is Node.DOCUMENT_FRAGMENT_NODE
			item =
				element: do node.nodeName.toLowerCase
				type:    type

			if do node.hasAttributes
				item.attrs = {}
				for index in [0...node.attributes.length]
					attr = node.attributes.item index
					item.attrs[attr.name] = attr.value

			if node.__objective and type isnt PuzzleTag.CLOSING
				item.objective = yes

			if node.hasChildNodes() and node.children.length is 0
				only_text = [].every.call node.childNodes, ({nodeType}) ->
					nodeType is Node.TEXT_NODE
				if only_text
					item.text = node.textContent

			item

	@to_tag_list: ({selector}, fragment) ->
		list = []
		objectives = fragment.querySelectorAll selector
		objective.__objective = yes for objective in objectives

		emit = (node, type) ->
			item = Puzzle.create_tag_item node, type
			node.__id = list.length if type isnt PuzzleTag.CLOSING
			list.push item if item?

		stack = [fragment]
		while stack.length isnt 0
			[..., node] = stack

			if node.childElementCount isnt 0
				children = [].slice.call node.children
				stack = stack.concat children.reverse()
				emit node, PuzzleTag.OPENING
			else
				emit node, PuzzleTag.SINGLE_LINE

				loop
					node = do stack.pop
					[..., top] = stack
					break unless top? and top.lastElementChild is node
					emit top, PuzzleTag.CLOSING

		list

	ASCENDING = (one, another) -> one - another

	constructor: (@data) ->
		@fragment = Puzzle.create_fragment @data.html
		@tags = Puzzle.to_tag_list @data, @fragment
		@objective =
			(index for tag, index in @tags when tag.objective)
			.sort ASCENDING

	select: (selector) ->
		try
			@fragment.querySelectorAll selector
		catch ex
			null

	match: (selector) ->
		position = null
		for banned in @data.banned
			position = selector.indexOf banned
			break if position isnt -1

		if position isnt -1 and position isnt null
			selector: selector
			result: SelectorMatchResult.NEGATIVE
			ids: []
			banned:
				character: banned
				at:        position
		else
			ids = []
			nodes = @select selector
			result =
				if nodes?
					ids = [].map.call nodes, (node) -> node.__id
						.sort ASCENDING
					if ids.length isnt @objective.length
						SelectorMatchResult.NEGATIVE
					else
						identical = ids.every (id, index) => @objective[index] is id
						if identical
							SelectorMatchResult.POSITIVE
						else
							SelectorMatchResult.NEGATIVE
				else
					SelectorMatchResult.NEGATIVE

			selector: selector
			result: result
			ids: ids

module.exports = Puzzle
