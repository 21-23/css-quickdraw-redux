co       = require 'co'
mongoose = require 'mongoose'

userSchema = new mongoose.Schema
	displayName:
		type: String
		required: yes
	id:
		type: String
		unique: true
		required: yes

userSchema.static 'fromOAuthProfile', co.wrap (profile) ->
	id = "#{profile.provider}#{profile.id}"

	found = yield @findOne(id: id).exec()
	if found then found else @create
		id: id
		displayName: profile.username or profile.displayName

module.exports = mongoose.model('User', userSchema)
