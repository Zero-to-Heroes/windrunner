_ = require 'lodash'
$ = require 'jquery'
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
		if (!@detectedHeroes?[0])
			@currentPick = 0
		console.log 'detected heroes, currentPick', @detectedHeroes, @currentPick

		# Go to the fisrt action - hero selection
		@goNextPick()

		# Notify the UI controller
		@emit 'replay-ready'

		# Preload the images
		images = @buildImagesArray()
		@preloadPictures images


	# ========================
	# Moving inside the replay (with player controls)
	# ========================
	goNextPick: ->
		@currentPick = Math.min(@currentPick + 1, 30)

	goPreviousPick: ->
		minPick = if @detectedHeroes?[0] then 0 else 1
		@currentPick = Math.max(@currentPick - 1, minPick)

	decoratePicks: (text) ->
		pickRegex = /(p|P)\d?\d(:|\s|,|\.|$)/gm

		that = this
		matches = text.match(pickRegex)

		if matches and matches.length > 0
			noDupesMatch = _.uniq matches
			noDupesMatch.forEach (match) ->
				find = match.trim()

				text = text.replace match, '<a ng-click="goToTimestamp(\'' + find + '\')" class="ng-scope">' + match + '</a>'

		# console.log 'modified text', text
		return text

	moveToPick: (pick) ->
		pickNumber = parseInt(pick.substring 1, pick.length)
		@currentPick = pickNumber
		@emit 'replay-ready'

	preloadPictures: (arrayOfImages) ->
		arrayOfImages.forEach (img) ->
			# console.log 'preloading', img
			(new Image()).src = img
		
		# console.log 'preloaded images'	

	buildImagesArray: ->
		images = []

		ids = []
		for cards in @detectedCards
			ids.push cards.Item1
			ids.push cards.Item2
			ids.push cards.Item3

		for id in ids
			images.push @cardUtils.buildFullCardImageUrl(@cardUtils.getCard(id))

		# console.log 'image array', images
		return images

	getPlayerInfo: ->
		heroCards = _.filter @cardUtils.jsonDatabase, (o) -> 
			return o.type == 'Hero' and o.playerClass and o.set == 'Basic'

		pickedHero = @pickedHero
		if pickedHero
			pickedCard = _.filter heroCards, (o) -> 
				o.playerClass.toLowerCase() == pickedHero.toLowerCase()

			playerInfo = {
				player: {
					'class': pickedCard[0]?.playerClass?.toLowerCase()
				}
			}
		
		return playerInfo

	isValid: ->
		return @detectedCards?.length > 0 and @pickedCards?.length > 0 and @pickedHero?.length > 0

module.exports = ReplayPlayer
