var nxt = {};

nxt.CommandCellModel = {

	cellStack: [],

	enter: function (cell) {
		var queue = [cell];

		if (cell.cleanup) {
			while (queue.length > 0) {
				var item = queue.shift();
				for (var index = 0; index < item.children.length; index++) {
					item.children[index].unbind();
					queue.push(item.children[index]);
				}
			}
			cell.children = [];
		}

		if (this.cellStack.length > 0) {
			var stackTop = this.cellStack[this.cellStack.length - 1];
			stackTop.children.push(cell);
		}

		this.cellStack.push(cell);
	},

	exit: function () {
		this.cellStack.pop();
	}

};

module.exports = nxt.CommandCellModel;
