var nx = {
	AjaxModel: require('../core/ajax-model').AjaxModel,
	Collection: require('../core/collection'),
	RestDocument: require('./rest-document'),
	Utils: require('../core/utils')
};

nx.RestCollection = function (options) {
	nx.Collection.call(this, options);
	nx.AjaxModel.call(this, options);
	this.options = options;

	var _this = this;
	this.bind(
		this.data,
		'<->',
		function (items) {
			return items.map(function (item) { return item.data.value; });
		},
		function (items) {
			return items.map(function (item) {
				return new _this.options.item(item);
			});
		}
	);
};

nx.Utils.mixin(nx.RestCollection.prototype, nx.Collection.prototype);
nx.Utils.mixin(nx.RestCollection.prototype, nx.AjaxModel.prototype);
nx.RestCollection.prototype.constructor = nx.RestCollection;

nx.RestCollection.prototype.request = function (options) {
	var _this = this;
	nx.AjaxModel.prototype.request.call(this, {
		url: this.options.url,
		method: options.method,
		success: function () {
			if (typeof options.success === 'function') {
				options.success(_this.items);
			}
		}
	});
};

nx.RestCollection.prototype.create = function (doc, done) {
	nx.RestDocument.prototype.request.call(doc, {
		url: this.options.url,
		method: 'post',
		success: done
	});
};

nx.RestCollection.prototype.retrieve = function (done) {
	this.request({ method: 'get', success: done });
};

nx.RestCollection.prototype.remove = function (doc, done) {
	var _this = this;
	doc.remove(function () {
		nx.Collection.prototype.remove.call(_this, doc);
		if (typeof done === 'function') {
			done();
		}
	});
};

module.exports = nx.RestCollection;
