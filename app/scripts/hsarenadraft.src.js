var hsarenadraft = {

	execute: function(review, text) {
		if (!text) return '';
		if (!window.replay) return text;

		// Get the appropriate timestamp (if any)
		text = window.replay.replaceKeywordsWithTimestamp(text);

		return text;
	},

	init: function(config, review) {
		console.log('init arena draft', review)
		var replayXml = review.replayXml;
		hsarenadraft.loadReplay(replayXml);
	},

	loadReplay: function(jsonReplay) {
		console.log('loading draft data', jsonReplay)
		var bundle = require('./js/src/front/bundle.js');
		bundle.init(jsonReplay);

		window.replay.cardUtils = window['parseCardsText']
	}
}

module.exports = hsarenadraft;