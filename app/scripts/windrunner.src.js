var windrunner = {

	execute: function(review, text) {
		// console.log('executing', text, window.windrunner_impl)
		if (!text) return ''
		if (!window.windrunner_impl) return text

		// Decorate the "pick numbers" to create links
		text = window.windrunner_impl.decoratePicks(text)
		// console.log('text decorated', text)

		return text
	},

	init: function(config, review) {
		var replayXml = review.replayXml
		windrunner.loadReplay(replayXml)
	},

	loadReplay: function(jsonReplay) {
		// console.log('loading replay for arenadraft')
		var bundle = require('./js/src/front/bundle.js')
		bundle.init(jsonReplay)

		window.windrunner_impl.cardUtils = window['parseCardsText']
	},

	goToTimestamp: function(pick) {
		window.windrunner_impl.moveToPick(pick)
	},

	onTurnChanged: function(callback) {
		window.windrunner_impl.onTurnChanged = function(turn) {
			callback(turn)
		}
	},

	getCurrentTimestamp: function() {
		return window.windrunner_impl.getCurrentPick().toLowerCase()
	},

	getPlayerInfo: function() {
		return window.windrunner_impl.getPlayerInfo()
	},

	isValid: function() {
		return window.windrunner_impl.isValid()
	}
}

module.exports = windrunner;