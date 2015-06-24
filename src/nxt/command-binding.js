var nx = {
	Binding: require('../core/binding'),
	Utils: require('../core/utils')
};

var nxt = {
	CommandCellModel: require('./command-cell-model')
};

nxt.CommandBinding = function (source, target, conversion) {
	nx.Binding.call(this, source, target, conversion);
	this.index = source._bindingIndex;
	source.bindings[source._bindingIndex++] = this;
};

nx.Utils.mixin(nxt.CommandBinding.prototype, nx.Binding.prototype);

nxt.CommandBinding.prototype.sync = function () {
	nxt.CommandCellModel.enter(this.target);
	nx.Binding.prototype.sync.call(this);
	nxt.CommandCellModel.exit();
};

module.exports = nxt.CommandBinding;
