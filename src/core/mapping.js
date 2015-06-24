var nx = {};

nx.Mapping = function (pattern) {
	this.pattern = pattern;
};

nx.Mapping.prototype.map = function (source, target) {
	if (typeof this.pattern !== 'undefined') {
		for (var item in this.pattern) {
			if (item === '_' && typeof target !== 'undefined') {
				target[this.pattern[item]] = source;
			} else if (this.pattern[item] === '_' && typeof source !== 'undefined') {
				target = source[item];
				return target;
			} else if (typeof source !== 'undefined' && typeof target !== 'undefined') {
				target[this.pattern[item]] = source[item];
			}
		}
		return target;
	} else {
		target = source;
		return target;
	}
};

nx.Mapping.prototype.inverse = function () {
	var inversePattern = {};
	for (var item in this.pattern) {
		inversePattern[this.pattern[item]] = item;
	}
	return new nx.Mapping(inversePattern);
};

module.exports = nx.Mapping;
