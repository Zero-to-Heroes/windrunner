var windrunner = {

	execute: function(review, text) {
		if (!text) return ''
		if (!window.windrunner) return text

		// Decorate the "pick numbers" to create links
		text = window.windrunner.decoratePicks(text)

		return text
	},

	init: function(config, review) {
		var replayXml = review.replayXml
		windrunner.loadReplay(replayXml)
	},

	loadReplay: function(jsonReplay) {
		console.log('loading replay for arenadraft')
		var bundle = require('./js/src/front/bundle.js')
		bundle.init(jsonReplay)

		window.windrunner.cardUtils = window['parseCardsText']
	},

	goToTimestamp: function(pick) {
		window.windrunner.moveToPick(pick)
	},

	getPlayerInfo: function() {
		console.log('retrieving player info')
		return window.windrunner.getPlayerInfo()
	},

	isValid: function() {
		return window.windrunner.isValid()
	},

	onTurnChanged: function(callback) {
		// Do nothing for now

	},

	getCurrentTimestamp: function() {
		return window.windrunner.getCurrentPick().toLowerCase()
	}
}

module.exports = windrunner;