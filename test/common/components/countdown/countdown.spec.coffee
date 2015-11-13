lolex = require 'lolex'

Countdown = require '../../../../app/common/components/countdown/countdown'

describe 'Countdown', ->

	clock = null

	before ->
		clock = do lolex.install

	after ->
		do clock.uninstall

	countdown = null

	beforeEach ->
		countdown = new Countdown
		countdown.time.value = 3000
		countdown.active.value = yes

	describe 'constructor', ->
		it 'sets `remaining` to the time value', ->
			countdown.remaining.value.should.equal 3000

	describe 'time', ->
		it 'resets the countdown with new time', ->
			countdown.time.value = 5000
			countdown.remaining.value.should.equal 5000

	describe 'remaining', ->
		it 'changes its value every second', ->
			clock.tick 1000
			countdown.remaining.value.should.equal 2000
			clock.tick 1000
			countdown.remaining.value.should.equal 1000

	describe 'active', ->
		it 'is set to `false` by default', ->
			countdown = new Countdown
			countdown.active.value.should.equal no

		it 'stops or starts/resumes the countdown', ->
			clock.tick 1000
			countdown.active.value = no
			clock.tick 1000
			countdown.remaining.value.should.equal 2000

		it 'is set to `false` when countdown reaches zero', ->
			clock.tick 3000
			countdown.active.value.should.equal no

	describe 'timeout', ->

		it 'is set to `true` when countdown reaches zero', ->
			clock.tick 3000
			countdown.timeout.value.should.equal yes
