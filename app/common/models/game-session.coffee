mongoose = require 'mongoose'

Schema = mongoose.Schema

GameSessionSchema = Schema
	game_master_id: Schema.Types.ObjectId
	puzzles: [{ type: Schema.Types.ObjectId, ref: 'Puzzle' }]

module.exports =
	GameSessionModel: mongoose.model 'GameSession', GameSessionSchema
	GameSessionSchema: GameSessionSchema
