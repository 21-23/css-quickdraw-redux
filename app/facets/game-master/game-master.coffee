{nx} = require 'nexus-node'

Participant = require '../common/participant'

class GameMaster extends Participant

	constructor: (service) -> super service

module.exports = GameMaster
