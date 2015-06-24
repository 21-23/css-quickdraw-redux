var nxt = {};

nxt.AttrRenderer = {

	render: function (data, domContext) {
		var attrMap = {};
		if (typeof data.items !== 'undefined') {
			for (var key in data.items) {
				if (key === 'value') {
					domContext.container.value = data.items[key];
				} else {
					domContext.container.setAttribute(key, data.items[key]);
				}
			}
			attrMap = data.items;
		} else {
			if (data.name === 'value') {
				domContext.container.value = data.value;
			}
			else {
				domContext.container.setAttribute(data.name, data.value);
			}
			attrMap[data.name] = data.value;
		}
		return attrMap;
	},

	unrender: function (domContext) {
		for (var key in domContext.content) {
			domContext.container.removeAttribute(key);
		}
	}
};

module.exports = nxt.AttrRenderer;
