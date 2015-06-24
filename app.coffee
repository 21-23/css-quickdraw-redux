PearlProgressIndicator = require './pearl-progress-indicator'
TaskPearlViewModel     = require './task-pearl-viewmodel'
TaskStatus             = require './task-status'

tasks = [
	{
		index: 1
		status: nx.Cell value:TaskStatus.COMPLETED
	}
	{
		index: 2
		status: nx.Cell value:TaskStatus.TIMEOUT
	}
	{
		index: 3
		status: nx.Cell value:TaskStatus.TIMEOUT
	}
	{
		index: 4
		status: nx.Cell value:TaskStatus.IN_PROGRESS
	}
	{
		index: 5
		status: nx.Cell value:TaskStatus.PENDING
	}
]

# new PearlProgressIndicator.ViewModel tasks, TaskPearlViewModel


