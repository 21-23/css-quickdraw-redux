TaskPearlViewModel     = require './task-pearl-viewmodel'
TaskStatus             = require './task-status'
PearlThread            = require './pearl-thread'

require './stylesheets/app.styl'

tasks = [
	{
		index: 1
		status: new nx.Cell value:TaskStatus.COMPLETED
	}
	{
		index: 2
		status: new nx.Cell value:TaskStatus.TIMEOUT
	}
	{
		index: 3
		status: new nx.Cell value:TaskStatus.TIMEOUT
	}
	{
		index: 4
		status: new nx.Cell value:TaskStatus.IN_PROGRESS
	}
	{
		index: 5
		status: new nx.Cell value:TaskStatus.PENDING
	}
]
document.body.appendChild PearlThread.View(new PearlThread.ViewModel tasks, TaskPearlViewModel).data.node
