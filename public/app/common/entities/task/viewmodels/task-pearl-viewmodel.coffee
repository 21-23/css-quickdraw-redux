TaskStatus       = require '../models/task-status'
{PearlViewModel} = require '../../../components/pearl-thread'

class TaskPearlViewModel extends PearlViewModel
	constructor: (task) ->
		super
		@text.value = task.index.toString()
		@modifier['<<-'] task.status, (status) ->
			TaskPearlViewModel.ModifierByStatus[status]

	@ModifierByStatus =
		"#{TaskStatus.COMPLETED}"  : '-completed'
		"#{TaskStatus.TIMEOUT}"    : '-timeout'
		"#{TaskStatus.IN_PROGRESS}": '-in-progress'
		"#{TaskStatus.PENDING}"    : '-pending'

module.exports = TaskPearlViewModel
