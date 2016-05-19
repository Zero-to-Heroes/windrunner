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
		pickRegex = /(p|P|pick|Pick|pick |Pick )(\d?\d)(:|\s|,|\.|$)/gm

		# console.log 'decorating pick', text

		that = this
		match = pickRegex.exec(text)
		# console.log 'atch regex', match
		replaced = []

		while (match) 
			# console.log 'match', match
			find = match[0].trim()
			if replaced.indexOf(find) == -1
				turnNumber = match[2]
				text = text.replace new RegExp(find, 'g'), '<a ng-click="mediaPlayer.goToTimestamp(\'' + turnNumber + '\')" class="ng-scope">' + find + '</a>'
				replaced.push find
			match = pickRegex.exec(text)

		# matches = text.match(pickRegex)

		# if matches and matches.length > 0
		# 	console.log 'matches is', matches
		# 	noDupesMatch = _.uniq matches
		# 	noDupesMatch.forEach (match) ->
		# 		console.log 'match is', match
		# 		find = match.trim()

		# 		text = text.replace match, '<a ng-click="mediaPlayer.goToTimestamp(\'' + find + '\')" class="ng-scope">' + match + '</a>'

		# console.log 'modified text', text
		return text

	moveToPick: (pick) ->
		pickNumber = parseInt(pick)
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
		return @detectedCards?.length > 0 and @pickedCards?.length > 0 and @pickedHero?.length > 0

module.exports = ReplayPlayer
