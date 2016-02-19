_ = require 'lodash'
EventEmitter = require 'events'

class ReplayPlayer extends EventEmitter
	constructor: (data) ->
		EventEmitter.call(this)

		window.replay_hsarenadraft = this

		@detectedHeroes = data.detectedheroes
		@pickedHero = data.pickedhero

		@detectedCards = data.detectedcards
		@pickedCards = data.pickedcards

		# 0 for hero pick, then p1 to p30 for the 30 card picks
		@currentPick = 0
		@cardUtils = window['parseCardsText']

	init: ->
		@currentPick = -1

		# Go to the fisrt action - hero selection
		@goNextPick()

		# Notify the UI controller
		@emit 'replay-ready'


	# ========================
	# Moving inside the replay (with player controls)
	# ========================
	goNextPick: ->
		@currentPick = Math.min(@currentPick + 1, 30)

	goPreviousPick: ->
		@currentPick = Math.max(@currentPick - 1, 0)

	decoratePicks: (text) ->
		# console.log 'decorating picks', text
		pickRegex = /(p|P)\d?\d(:|\s|,|\.|$)/gm

		that = this
		matches = text.match(pickRegex)
		# console.log '\tmatches', matches

		if matches and matches.length > 0
			noDupesMatch = _.uniq matches
			# console.log 'single matches', noDupesMatch
			noDupesMatch.forEach (match) ->
				find = match.trim()
				# console.log '\tmatch', match, find

				text = text.replace match, '<a ng-click="goToTimestamp(\'' + find + '\')" class="ng-scope">' + match + '</a>'

		# console.log 'modified text', text
		return text

	moveToPick: (pick) ->
		pickNumber = parseInt(pick.substring 1, pick.length - 1)
		# console.log 'moving to pick', pickNumber
		@currentPick = pickNumber
		@emit 'replay-ready'


module.exports = ReplayPlayer
