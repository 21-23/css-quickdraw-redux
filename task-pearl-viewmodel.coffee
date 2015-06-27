TaskStatus       = require './task-status'
{PearlViewModel} = require './pearl-thread'

class TaskPearlViewModel extends PearlViewModel
	constructor: (task) ->
		super
		@text.value = task.index.toString()
		@color['<<-'] task.status, (status) ->
			TaskPearlViewModel.ColorByStatus[status]

	@ColorByStatus =
		"#{TaskStatus.COMPLETED}"  : 'green'
		"#{TaskStatus.TIMEOUT}"    : 'crimson'
		"#{TaskStatus.IN_PROGRESS}": 'gold'
		"#{TaskStatus.PENDING}"    : 'white'

module.exports = TaskPearlViewModel
