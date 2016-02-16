var hsarenadraft = {

	execute: function(review, text) {
		console.log('will decorate text?', text)
		if (!text) return ''
		if (!window.replay_hsarenadraft) return text

		// Decorate the "pick numbers" to create links
		console.log('decorating text', text)
		text = window.replay_hsarenadraft.decoratePicks(text)

		return text
	},

	init: function(config, review) {
		var replayXml = review.replayXml
		hsarenadraft.loadReplay(replayXml)
	},

	loadReplay: function(jsonReplay) {
		var bundle = require('./js/src/front/bundle.js')
		bundle.init(jsonReplay)

		window.replay_hsarenadraft.cardUtils = window['parseCardsText']
	},

	goToTimestamp: function(pick) {
		console.log('moving to pick', pick)
		window.replay_hsarenadraft.moveToPick(pick)
	}
}

module.exports = hsarenadraft;