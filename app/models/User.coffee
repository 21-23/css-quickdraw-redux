co       = require 'co'
mongoose = require 'mongoose'

userSchema = new mongoose.Schema
	displayName:
		type: String
		required: yes
	id:
		type: String
		unique: yes
		required: yes
	role:
		type: String
		enum: ['game_master', 'player']
		default: 'player'

userSchema.static 'fromOAuthProfile', co.wrap (profile) ->
	id = "#{profile.provider}#{profile.id}"

	found = yield @findOne(id: id).exec()
	found or @create
		id: id
		displayName: profile.username or profile.displayName

module.exports = mongoose.model('User', userSchema)
