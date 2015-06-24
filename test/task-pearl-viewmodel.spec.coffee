TaskPearlViewModel = require '../task-pearl-viewmodel'
TaskStatus         = require '../task-status'
{nx} = require 'nexus'

describe 'TaskPearlViewModel', ->

	view_model = null
	task = null

	beforeEach ->
		task =
			index: 1
			status: nx.Cell value:TaskStatus.PENDING
		view_model = new TaskPearlViewModel task

	describe 'constructor', ->
		it 'sets the text cell value to task\'s index as a string', ->
			view_model.text.value.should.equal task.index.toString()

	describe 'status-color binding', ->
		it 'sets the color cell value to converted status color', ->
			view_model.color.value.should.equal TaskPearlViewModel.StatusColor[task.status]

		it 'updates the color using the view model\'s color map', ->
			for status of TaskStatus
				task.status.value = status
				view_model.color.value.should.equal TaskPearlViewModel.StatusColor[status]

