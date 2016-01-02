ToggleListViewModel = require '../toggle-list.viewmodel'

describe 'ToggleListViewModel', ->

	toggle_list = null

	beforeEach ->
		toggle_list = new ToggleListViewModel
		toggle_list.items.value = ['a', 'b', 'c']

	describe 'toggles', ->
		it 'transforms `items` into toggle view models', ->
			toggle_list.toggles.value.should.have.property 'length', 3
			toggle_list.toggles.value
				.map ({toggled}) -> toggled.value
				.should.deep.equal [no, no, no]


	describe 'get_toggles', ->
		it 'creates item-picking functions using an array of item indexes from the update cell', ->
			picker = toggle_list.get_toggles 'set'
			update = set: [1, 2]
			toggles = update.set.map (index) -> toggle_list.toggles.value[index].toggled
			picker(update).should.deep.equal toggles

	describe 'toggle_update', ->
		it 'updates toggles with `set` indexes with `true`', ->
			toggle_list.toggle_update.value =
				set:   [0, 2]
				unset: []
			toggle_list.toggles.value[0].toggled.value.should.equal yes
			toggle_list.toggles.value[2].toggled.value.should.equal yes

		it 'updates toggles with `unset` indexes with `false`', ->
			toggle_list.toggle_update.value =
				set:  []
				unset:[1, 2]
			toggle_list.toggles.value[1].toggled.value.should.equal no
			toggle_list.toggles.value[2].toggled.value.should.equal no

	describe 'pick', ->
		it 'creates a toggle update from array of indexes', ->
			toggle_list.pick.value = [0, 2]
			toggle_list.toggle_update.value.should.deep.equal
				set:   [0, 2]
				unset: []

		it 'unsets previously set toggles', ->
			toggle_list.pick.value = [0]
			toggle_list.pick.value = [1, 2]
			toggle_list.toggle_update.value.should.deep.equal
				set:   [1, 2]
				unset: [0]

		it 'doesn\'t unset toggles that are set again', ->
			toggle_list.pick.value = [0, 1]
			toggle_list.pick.value = [1, 2]
			toggle_list.toggle_update.value.should.deep.equal
				set:   [2]
				unset: [0]

