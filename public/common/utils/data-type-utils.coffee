module.exports = {
	isNumeric: (value) -> not isNaN(parseFloat value ) and isFinite value
}
