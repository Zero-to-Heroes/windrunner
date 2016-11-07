_ = require 'lodash'
$ = require 'jquery'
EventEmitter = require 'events'

class ReplayPlayer extends EventEmitter
	constructor: (data) ->
		EventEmitter.call(this)

		window.windrunner_impl = this

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
		@notifyChangePick()

	goPreviousPick: ->
		minPick = if @detectedHeroes?[0] then 0 else 1
		@currentPick = Math.max(@currentPick - 1, minPick)
		@notifyChangePick()

	decoratePicks: (text) ->
		# https://regex101.com/r/zX2gF9/1
		pickRegex = /(?:p(?:ick )?|P(?:ick )?)(\d?\d)(?::|\s|,|\.|$)/gm

		console.log 'decorating pick', text
		that = this

		match = pickRegex.exec(text)
		while match
			console.log 'match!', match
			pickNumber = parseInt(match[1])
			replaceString = '<a ng-click="mediaPlayer.goToTimestamp(\'' + pickNumber + '\')" class="ng-scope">' + match[0] + '</a>'
			text = text.substring(0, match.index) + replaceString + text.substring(match.index + match[0].length)
			# Approximate length of the new chain
			pickRegex.lastIndex += replaceString.length
			match = pickRegex.exec(text)


		return text

	moveToPick: (pick) ->
		pickNumber = parseInt(pick)
		@currentPick = pickNumber
		@notifyChangePick()
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
			ids.push cards?.Item1
			ids.push cards?.Item2
			ids.push cards?.Item3

		for id in ids
			images.push @cardUtils.buildFullCardImageUrl(@cardUtils.getCard(id))

		# console.log 'image array', images
		return images

	getPlayerInfo: ->
		heroCards = _.filter @cardUtils.jsonDatabase, (o) -> 
			return o.type == 'Hero' and o.playerClass and o.set == 'Core'

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
		console.log('file valid?', @detectedCards, @pickedCards, @pickedHero)
		return @detectedCards?.length > 0 and @pickedCards?.length > 0 and @pickedHero?.length > 0


	getCurrentPick: ->
		return 'p' + @currentPick

	notifyChangePick: (inputPick) ->
		pickNumber = inputPick || @currentPick
		pickNumber = 'p' + pickNumber

		@onTurnChanged? pickNumber

module.exports = ReplayPlayer
