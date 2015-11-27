User  = require 'app/models/User.coffee'

require '../db.coffee'

profile = null

checkUserExists = (id) ->
	User
		.findOne id: id
		.exec()
		.then (found) ->
			unless found
				throw new Error 'User not found'

describe 'User', ->
	describe '#fromOAuthProfile', ->

		beforeEach ->
			profile =
				id: 'id'
				provider: 'provider'
				username: 'username'

		afterEach (done) ->
			User.remove {}, done

		it "creates new user if user with the same id doesn't exist", ->
			yield User.fromOAuthProfile profile
			yield checkUserExists 'providerid'

		it 'returns existing user', ->
			newUser      = yield User.fromOAuthProfile profile
			existingUser = yield User.fromOAuthProfile profile

			newUser._id.should.deep.equal existingUser._id

		it 'joins provider name with profile id to create userid', ->
			user = yield User.fromOAuthProfile profile
			user.id.should.equal 'providerid'

		it 'assigns profile username to user displayName', ->
			user = yield User.fromOAuthProfile profile
			user.displayName.should.equal profile.username

		it 'assigns profile username to user displayName even if profile has displayName', ->
			profile.displayName = 'displayName'
			user = yield User.fromOAuthProfile profile
			user.displayName.should.equal profile.username

		it 'assigns profile displayName to user displayName if there is no username in profile', ->
			profile.displayName = 'displayName'
			delete profile.username
			user = yield User.fromOAuthProfile profile
			user.displayName.should.equal profile.displayName
