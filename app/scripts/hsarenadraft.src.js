var hsarenadraft = {

	execute: function(review, text) {
		if (!text) return ''
		if (!window.replay_hsarenadraft) return text

		// Decorate the "pick numbers" to create links
		text = window.replay_hsarenadraft.decoratePicks(text)

		return text
	},

	init: function(config, review) {
		var replayXml = review.replayXml
		hsarenadraft.loadReplay(replayXml)
	},

	loadReplay: function(jsonReplay) {
		console.log('loading replay for arenadraft')
		var bundle = require('./js/src/front/bundle.js')
		bundle.init(jsonReplay)

		window.replay_hsarenadraft.cardUtils = window['parseCardsText']
	},

	goToTimestamp: function(pick) {
		window.replay_hsarenadraft.moveToPick(pick)
	},

	getPlayerInfo: function() {
		console.log('retrieving player info')
		return window.replay_hsarenadraft.getPlayerInfo()
	},

	isValid: function() {
		return window.replay_hsarenadraft.isValid()
	},

	onTurnChanged: function(callback) {
		// Do nothing for now

	},

	getCurrentTimestamp: function() {
		return window.replay_hsarenadraft.getCurrentPick().toLowerCase()
	}
}

module.exports = hsarenadraft;