var nx = {
	Mapping: require('./mapping')
};

nx.Binding = function (source, target, conversion) {
	this.source = source;
	this.target = target;

	this.conversion = conversion;
};

nx.Binding.prototype.sync = function () {
	if (typeof this.lock !== 'undefined') {
		if (this.lock.locked) {
			this.lock.locked = false;
			return;
		} else {
			this.lock.locked = true;
		}
	}

	var value = this.source.value;
	if (typeof this.conversion !== 'undefined') {
		if (this.conversion instanceof nx.Mapping) {
			value = this.conversion.map(value, this.target.value);
		} else if (typeof this.conversion === 'function') {
			value = this.conversion(value);
		}
	}
	this.target.value = value;
};

nx.Binding.prototype.pair = function (binding) {
	this.lock = binding.lock = { locked: false };
	return this.lock;
};

nx.Binding.prototype.unbind = function () {
	delete this.source.bindings[this.index];
};

module.exports = nx.Binding;
