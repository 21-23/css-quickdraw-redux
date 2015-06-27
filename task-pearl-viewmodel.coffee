TaskStatus       = require './task-status'
{PearlViewModel} = require './pearl-thread'

class TaskPearlViewModel extends PearlViewModel
	constructor: (task) ->
		super
		@text.value = task.index.toString()
		@color['<<-'] task.status, (status) ->
			TaskPearlViewModel.ColorByStatus[status]

	@ColorByStatus =
		"#{TaskStatus.COMPLETED}"  : '#a7ffa7'
		"#{TaskStatus.TIMEOUT}"    : '#ff9b9b'
		"#{TaskStatus.IN_PROGRESS}": '#ffc469'
		"#{TaskStatus.PENDING}"    : 'white'

module.exports = TaskPearlViewModel
