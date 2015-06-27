TaskPearlViewModel = require '../task-pearl-viewmodel'
TaskStatus         = require '../task-status'
{nx} = require 'nexus'

describe 'TaskPearlViewModel', ->

	view_model = null
	task = null

	beforeEach ->
		task =
			index: 1
			status: new nx.Cell value:TaskStatus.PENDING
		view_model = new TaskPearlViewModel task

	describe 'constructor', ->
		it 'sets the text cell value to task\'s index as a string', ->
			view_model.text.value.should.equal task.index.toString()

	describe 'status-modifier binding', ->
		it 'sets the modifier cell value to converted status modifier', ->
			modifier = TaskPearlViewModel.ModifierByStatus[task.status.value]
			view_model.modifier.value.should.equal modifier

		it 'updates the modifier using the view model\'s color map', ->
			for _, status of TaskStatus
				task.status.value = status
				modifier = TaskPearlViewModel.ModifierByStatus[status]
				view_model.modifier.value.should.equal modifier
