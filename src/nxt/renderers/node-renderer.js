var nxt = {};

nxt.NodeRenderer = {

	render: function (data, domContext) {
		if (typeof domContext.content !== 'undefined') {
			domContext.container.replaceChild(data.node, domContext.content);
		} else if (typeof domContext.insertReference !== 'undefined') {
			domContext.container.insertBefore(data.node, domContext.insertReference);
		} else {
			domContext.container.appendChild(data.node);
		}
		return data.node;
	},

	visible: function (content) {
		return typeof content !== 'undefined'
			&& (content.nodeType === Node.ELEMENT_NODE || content.nodeType === Node.TEXT_NODE);
	},

	unrender: function (domContext) {
		domContext.container.removeChild(domContext.content);
	}

};

module.exports = nxt.NodeRenderer;
