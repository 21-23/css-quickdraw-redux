var nxt = require('./renderers');
nxt.Command = require('./command');
nxt.ContentRegion = require('./content-region');

nxt.ContentRenderer = {

	render: function (data, domContext) {
		var cells = [];
		var contentItems = [];
		var _this = this;

		data.items.forEach(function (command) {
			if (command !== undefined) {
				if (command instanceof nxt.Command) {
					var content = command.run(domContext);
					contentItems.push(content);
					if (cells.length > 0) { // dynamic content followed by static content
						var regionContext = { container: domContext.container };
						// only DOM-visible items can serve as an insert reference
						if (nxt.NodeRenderer.visible(content)) {
							regionContext.insertReference = content;
						}
						_this.createRegion(regionContext, cells);
						cells = [];
					}
				} else { // command is really a cell
					cells.push(command);
				}
			}
		});

		if (cells.length > 0) {
			// no need for an insert reference as these cells' content is appended by default
			this.createRegion({ container: domContext.container, insertReference: domContext.insertReference }, cells);
		}
		return contentItems;
	},

	createRegion: function (domContext, cells) {
		var newRegion = new nxt.ContentRegion(domContext);
		for (var itemIndex = 0; itemIndex < cells.length; itemIndex++) {
			newRegion.add(cells[itemIndex]);
		}
		return newRegion;
	},

	append: function (data, domContext) {
		return (domContext.content || []).concat(
			this.render(data, {
				container: domContext.container,
				insertReference: domContext.insertReference
			})
		);
	},

	insertBefore: function (data, domContext) {
		var insertReference = domContext.content[data.index];
		var content = data.items.map(function (item) {
			return item.run({
				container: domContext.container,
				insertReference: insertReference
			});
		});
		[].splice.apply(
			domContext.content,
			[data.index, 0].concat(content)
		);
		return domContext.content;
	},

	remove: function (data, domContext) {
		data.indexes
			.sort(function (a, b) { return a - b; })
			.forEach(function (removeIndex, index) {
				domContext.container.removeChild(domContext.content[removeIndex - index]);
				domContext.content.splice(removeIndex - index, 1);
			});
		return domContext.content;
	},

	reset: function (data, domContext) {
		if (typeof domContext.content !== 'undefined') {
			for (var index = 0; index < domContext.content.length; index++) {
				domContext.container.removeChild(domContext.content[index]);
			}
			delete domContext.content;
		}
		return this.render(data, domContext);
	},

	swap: function (data, domContext) {
		data.indexes.sort(function (a, b) { return a - b; });
		var firstIndex = data.indexes[0];
		var secondIndex = data.indexes[1];
		var firstNode = domContext.content[firstIndex];
		var secondNode = domContext.content[secondIndex];
		var sibling = null;
		if (data.indexes[1] < domContext.content.length - 1) {
			sibling = domContext.content[secondIndex + 1];
		}
		domContext.container.insertBefore(secondNode, firstNode);
		domContext.container.insertBefore(firstNode, sibling);
		domContext.content[firstIndex] = secondNode;
		domContext.content[secondIndex] = firstNode;
		return domContext.content;
	},

	get: function (data, domContext) {
		data.next(domContext.content);
		return domContext.content;
	},

	visible: function (content) {
		return content.some(nxt.NodeRenderer.visible);
	}
};

module.exports = nxt.ContentRenderer;
