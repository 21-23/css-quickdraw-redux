var nx = {
	ArrayTransform: require('./array-transform'),
	Cell: require('./cell'),
	Utils: require('./utils')
};

var nxt = {
	Command: require('../nxt/command')
};

nx.Collection = function (options) {
	options = options || {};
	nx.Cell.call(this);

	var _this = this;

	this.value = options.items || [];

	this.command = new nx.Cell();
	this['<->'](
		this.command,
		function (items) {
			return new nxt.Command('Content', 'reset', { items: items });
		},
		function (command) {
			return nx.ArrayTransform(_this.items, command);
		}
	);

	this.length = new nx.Cell({ value: this.items.length });
	this.length['<-'](this, function (items) { return items.length; });
};

nx.Utils.mixin(nx.Collection.prototype, nx.Cell.prototype);
nx.Collection.prototype.constructor = nx.Collection;

Object.defineProperty(nx.Collection.prototype, 'items', {
	enumerable : true,
	get: function () { return this.value; },
	set: function (items) {
		this.value = items;
	}
});

nx.Collection.prototype.append = function () {
	var args = [].slice.call(arguments);
	this.command.value = new nxt.Command('Content', 'append', { items: args });
};

nx.Collection.prototype.remove = function () {
	var args = [].slice.call(arguments);
	var _this = this;
	var indexes = args.map(function (item) {
		return _this.items.indexOf(item);
	});
	this.command.value = new nxt.Command('Content', 'remove', { indexes: indexes });
};

nx.Collection.prototype.insertBefore = function (beforeItem, items) {
	items = Array.isArray(items) ? items : [items];
	var insertIndex = this.items.indexOf(beforeItem);
	this.command.value = new nxt.Command('Content', 'insertBefore', {
		items: items,
		index: insertIndex
	});
};

nx.Collection.prototype.reset = function (items) {
	this.command.value = new nxt.Command('Content', 'reset', { items: items || [] });
};

nx.Collection.prototype.swap = function (firstItem, secondItem) {
	var firstIndex = this.items.indexOf(firstItem);
	var secondIndex = this.items.indexOf(secondItem);
	this.command.value = new nxt.Command('Content', 'swap', {
		indexes: [firstIndex, secondIndex]
	});
};

module.exports = nx.Collection;
