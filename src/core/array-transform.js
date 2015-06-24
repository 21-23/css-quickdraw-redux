var nx = {};

nx.ArrayTransform = function (array, command) {
	return nx.ArrayTransform[command.method](array, command.data);
};

// transformations are applied "in place" to create fewer objects
// which doesn't affect the cell value updating mechanism and data flow

nx.ArrayTransform.append = function (array, data) {
	[].push.apply(array, data.items);
	return array;
};

nx.ArrayTransform.remove = function (array, data) {
	data.indexes.forEach(function (index, count) {
		array.splice(index - count, 1);
	});
	return array;
};

nx.ArrayTransform.insertBefore = function (array, data) {
	[].splice.apply(array, [data.index, 0].concat(data.items));
	return array;
};

nx.ArrayTransform.reset = function (array, data) {
	return data.items;
};

nx.ArrayTransform.swap = function (array, data) {
	var temp = array[data.indexes[0]];
	array[data.indexes[0]] = array[data.indexes[1]];
	array[data.indexes[1]] = temp;
	return array;
};

module.exports = nx.ArrayTransform;
