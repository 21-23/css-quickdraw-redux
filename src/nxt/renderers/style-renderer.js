var nxt = {};

nxt.StyleRenderer = {

	render: function (data, domContext) {
		for (var key in data) {
			domContext.container.style.setProperty(key, data[key]);
		}
		return data;
	},

	unrender: function (domContext) {
		for (var key in domContext.content) {
			domContext
				.container
				.style
				.removeProperty(key);
		}
	}
};

module.exports = nxt.StyleRenderer;
