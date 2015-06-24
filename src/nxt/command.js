var nxt = require('./renderers');

nxt.Command = function (type, method, data) {
	this.type = type;
	this.method = method;
	this.data = data;
};

nxt.Command.prototype.run = function () {
	this.renderer = nxt[this.type + 'Renderer'];
	return this.renderer[this.method].apply(
		this.renderer,
		[this.data].concat([].slice.apply(arguments))
	);
};

module.exports = nxt.Command;
