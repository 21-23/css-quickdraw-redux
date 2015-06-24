var nxt = {};

nxt.EventRenderer = {

	add: function (data, domContext) {
		domContext.container.addEventListener(data.name, data.handler);
		return data;
	},

	unrender: function (domContext) {
		domContext.container.removeEventListener(domContext.content.name, domContext.content.handler);
	}

};

module.exports = nxt.EventRenderer;
