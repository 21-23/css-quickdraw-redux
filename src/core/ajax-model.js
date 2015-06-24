var nx = {
	Cell: require('./cell'),
	Utils: require('./utils')
};

nx.AsyncStatus = {
	LOADING: 1,
	DONE: 2,
	ERROR: 3
};

nx.AjaxModel = function (options) {
	options = options || {};

	this.data = new nx.Cell();
	this.error = new nx.Cell();
	this.status = new nx.Cell();

	if (typeof options.data !== 'undefined') {
		this.data.value = options.data;
	}
};

nx.AjaxModel.prototype.request = function (options) {
	var _this = this;
	var url = nx.Utils.interpolateString(options.url, this.data.value);
	this.xhr = new XMLHttpRequest();
	this.xhr.open(options.method, url, true);
	this.xhr.responseType = (!window.chrome) ? 'json' : 'text';

	this.xhr.onload = function () {
		var handler, data;

		if (this.responseType === 'json') {
			data = this.response;
		} else if (this.responseText) {
			data = JSON.parse(this.responseText);
		}

		if (this.status === 200 || this.status === 201 || this.status === 204) {
			handler = options.success;
			_this.data.value = data;
			_this.status.value = nx.AsyncStatus.DONE;
		} else {
			handler = options.error;
			_this.error.value = data;
			_this.status.value = nx.AsyncStatus.ERROR;
		}

		if (typeof handler === 'function') {
			handler(data);
		}
	};

	if (options.method === 'post' || options.method === 'put') {
		this.xhr.setRequestHeader('Content-Type', 'application/json');
		this.xhr.send(JSON.stringify(this.data.value));
	} else {
		this.xhr.send();
	}
	_this.status.value = nx.AsyncStatus.LOADING;
};

module.exports = {
	AjaxModel: nx.AjaxModel,
	AsyncStatus: nx.AsyncStatus
};

