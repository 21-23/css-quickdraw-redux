var nx = window.nx = {
	/* Core */
	AjaxModel:   require('./core/ajax-model').AjaxModel,
	AsyncStatus: require('./core/ajax-model').AsyncStatus,
	Binding:     require('./core/binding'),
	Cell:        require('./core/cell'),
	Collection:  require('./core/collection'),
	Mapping:     require('./core/mapping'),

	/* REST */
	RestCollection: require('./rest/rest-collection'),
	RestDocument:   require('./rest/rest-document')
};

var nxt = window.nxt = require('./nxt/helpers');

module.exports = {
	nx: nx,
	nxt: nxt
};
