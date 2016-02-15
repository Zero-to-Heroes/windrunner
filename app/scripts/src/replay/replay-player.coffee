_ = require 'lodash'
EventEmitter = require 'events'

class ReplayPlayer extends EventEmitter
	constructor: (data) ->
		EventEmitter.call(this)

		window.replay = this

		console.log 'init data', data

		@detectedHeroes = data.detectedheroes
		@pickedHero = data.pickedhero

		@detectedCards = data.detectedcards
		@pickedCards = data.pickedcards

		# 0 for hero pick, then p1 to p30 for the 30 card picks
		@currentPick = 0
		@cardUtils = window['parseCardsText']

	init: ->
		console.log 'starting init'
		@currentPick = -1

		# Go to the fisrt action - hero selection
		@goNextPick()

		# Notify the UI controller
		@emit 'replay-ready'


	# ========================
	# Moving inside the replay (with player controls)
	# ========================
	goNextPick: ->
		console.log 'going to next pick'
		@currentPick = Math.min(@currentPick + 1, 30)
		@handlePick()

	goPreviousPick: ->
		console.log 'going to next pick'
		@currentPick = Math.max(@currentPick - 1, 0)
		@handlePick()


	handlePick: ->
		if @currentPick == 0
			console.log 'Picking hero', @detectedHeroes
			console.log '\tPicked hero', @pickedHero

		else
			console.log 'Picking card', @detectedCards[@currentPick - 1]
			console.log '\tPicked card', @pickedCards[@currentPick - 1]

	replaceKeywordsWithTimestamp: (text) ->
		return text


module.exports = ReplayPlayer
