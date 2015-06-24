var nx = {};

nx.Utils = {

	interpolateString: function (string, props) {
		var matches = string.match(/[^{\}]+(?=\})/g);
		if (matches) {
			matches.forEach(function (match) {
				string = string.replace('{' + match + '}', props[match]);
			});
		}
		return string;
	},

	mixin: function (target, source) {
		var keys = Object.getOwnPropertyNames(source);
		keys.forEach(function (key) {
			var desc = Object.getOwnPropertyDescriptor(source, key);
			Object.defineProperty(target, key, desc);
		});
	}

};

module.exports = nx.Utils;
