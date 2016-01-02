Puzzle              = require '../puzzle'
PuzzleTag           = require '../puzzle-tag'
SelectorMatchResult = require '../selector-match-result'

describe 'Puzzle', ->

	puzzle_data =
		html:
			'''
			<header>header</header>
			<main>
				<div class="match">cellar door</div>
			</main>
			<footer>footer</footer>
			'''

		selector: '.match'
		name: 'Fake Puzzle'
		banned: ['_']

	describe 'constructor', ->
		it 'creates a document fragment from the puzzle data', ->
			puzzle = new Puzzle puzzle_data
			puzzle.fragment.should.be.an.instanceof DocumentFragment

		it 'creates tag list data structure and objectives array from the puzzle data', ->
			puzzle = new Puzzle puzzle_data
			fragment = Puzzle.create_fragment puzzle_data.html
			tags = Puzzle.to_tag_list puzzle_data, fragment
			puzzle.tags.should.deep.equal tags

		it 'gets an array of ids of objective nodes in the tag list', ->
			puzzle = new Puzzle puzzle_data
			puzzle.objective.should.deep.equal [2]

	describe 'create_tag_item', ->
		it 'sets tag type and element name', ->
			node = document.createElement 'input'
			item = Puzzle.create_tag_item node, PuzzleTag.OPENING
			item.element.should.equal node.nodeName.toLowerCase()
			item.type.should.equal PuzzleTag.OPENING

		it 'doesn\'t return anything if node is document fragment', ->
			fragment = Puzzle.create_fragment puzzle_data.html
			item = Puzzle.create_tag_item fragment, PuzzleTag.OPENING
			should.not.exist item

		it 'maps node\'s attributes if it has any', ->
			node = document.createElement 'input'
			node.setAttribute 'id', 'yo'
			node.setAttribute 'value', 'cellar door'

			item = Puzzle.create_tag_item node, PuzzleTag.OPENING
			item.attrs.should.deep.equal
				id:    'yo'
				value: 'cellar door'

			node = document.createElement 'input'
			item = Puzzle.create_tag_item node, PuzzleTag.OPENING
			should.not.exist item.attrs

		it 'sets `objective` to yes if node is marked as an objective node', ->
			node = document.createElement 'input'
			item = Puzzle.create_tag_item node, PuzzleTag.OPENING
			should.not.exist node.objective
			node.__objective = yes
			item = Puzzle.create_tag_item node, PuzzleTag.OPENING
			item.objective.should.equal yes

	describe 'to_tag_list', ->
		it 'transforms puzzle data to flat node list', ->
			fragment = Puzzle.create_fragment puzzle_data.html
			tag_list = Puzzle.to_tag_list puzzle_data, fragment
			tag_list.should.deep.equal [
				{
					element: 'header'
					text:   'header'
					type:    PuzzleTag.SINGLE_LINE
				}

				{
					element: 'main'
					type:    PuzzleTag.OPENING
				}

				{
					element:  'div'
					attrs:
						class:  'match'
					objective: yes
					text:   'cellar door'
					type:   PuzzleTag.SINGLE_LINE
				}

				{
					element: 'main'
					type:   PuzzleTag.CLOSING
				}

				{
					element: 'footer'
					text:   'footer'
					type:   PuzzleTag.SINGLE_LINE
				}

			]

	describe 'create_fragment', ->
		it 'creates an HTML document fragment from HTML string', ->
			html = '''<div>
									<span>cellar door</span>
								</div>'''

			fragment = Puzzle.create_fragment html
			fragment.should.be.an.instanceof DocumentFragment
			fragment.firstChild.nodeName.should.equal 'DIV'
			fragment.firstChild.firstElementChild.nodeName.should.equal 'SPAN'

		it 'stores a tag list reference in every node', ->
			puzzle = new Puzzle puzzle_data
			all_nodes = [].slice.call puzzle.fragment.querySelectorAll '*'
			all_nodes
				.every (node) ->
					puzzle.tags[node.__id].element is node.nodeName.toLowerCase()
				.should.equal true

		it 'sets `__objective` to true for objective nodes', ->
			puzzle = new Puzzle puzzle_data
			all_nodes = [].slice.call puzzle.fragment.querySelectorAll '*'
			all_nodes
				.every (node) ->
					puzzle.tags[node.__id].element is node.nodeName.toLowerCase()
				.should.equal true

	describe 'match', ->
		it 'matches a selector to the fragment and returns an array of node ids and match result', ->
			puzzle = new Puzzle puzzle_data
			selector = '*'
			match = puzzle.match selector
			match.should.deep.equal
				selector: selector
				result: SelectorMatchResult.NEGATIVE
				ids:    [0, 1, 2, 4]

			selector = 'div, footer'
			match = puzzle.match selector
			match.should.deep.equal
				selector: selector
				result: SelectorMatchResult.NEGATIVE
				ids:    [2, 4]

			selector = '.match'
			match = puzzle.match selector
			match.should.deep.equal
				selector: selector
				result: SelectorMatchResult.POSITIVE
				ids:    [2]

		it 'returns a negative match when qSA fails', ->
			puzzle = new Puzzle puzzle_data
			selector = '='
			match = puzzle.match selector
			match.should.deep.equal
				selector: selector
				result: SelectorMatchResult.NEGATIVE
				ids:    []

		it 'returns a negative match when banned characters are encountered', ->
			puzzle = new Puzzle puzzle_data
			selector = '.mat_ch'
			match = puzzle.match selector
			match.should.deep.equal
				selector: selector
				result: SelectorMatchResult.NEGATIVE
				ids: []
				banned:
					character: '_'
					at: 4

		it 'doesn\'t check for banned characters when there aren\'t any', ->
			puzzle = new Puzzle
				html:     puzzle_data.html
				selector: puzzle_data.selector
				name:     puzzle_data.name
				banned:   []

			selector = '.match'
			match = puzzle.match selector
			match.should.deep.equal
				selector: selector
				result: SelectorMatchResult.POSITIVE
				ids:    [2]
