mongoose = require 'mongoose'

Schema = mongoose.Schema

GameSessionSchema = Schema
	puzzles: [{ type: Schema.Types.ObjectId, ref: 'Puzzle' }]

module.exports =
	GameSessionModel: mongoose.model 'GameSession', GameSessionSchema
	GameSessionSchema: GameSessionSchema
