var nx = {
	AjaxModel: require('../core/ajax-model').AjaxModel,
	Utils: require('../core/utils')
};

nx.RestDocument = function (options) {
	nx.AjaxModel.call(this, options);
	this.options = options;
};

nx.Utils.mixin(nx.RestDocument.prototype, nx.AjaxModel.prototype);
nx.RestDocument.prototype.constructor = nx.RestDocument;

nx.RestDocument.prototype.request = function (options) {
	nx.AjaxModel.prototype.request.call(this, {
		url: options.url || this.options.url,
		method: options.method,
		success: options.success
	});
};

nx.RestDocument.prototype.retrieve = function (done) {
	this.request({ method: 'get', success: done	});
};

nx.RestDocument.prototype.save = function (done) {
	this.request({ method: 'put', success: done	});
};

nx.RestDocument.prototype.remove = function (done) {
	this.request({ method: 'delete', success: done });
};

module.exports = nx.RestDocument;
