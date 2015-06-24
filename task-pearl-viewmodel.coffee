TaskStatus = require './task-status'

class TaskPearlViewModel

	@StatusColor =
		"#{TaskStatus.COMPLETED}"  : 'green'
		"#{TaskStatus.TIMEOUT}"    : 'crimson'
		"#{TaskStatus.IN_PROGRESS}": 'gold'
		"#{TaskStatus.PENDING}"    : 'white'

module.exports = TaskPearlViewModel
