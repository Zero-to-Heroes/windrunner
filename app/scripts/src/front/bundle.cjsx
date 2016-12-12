bundle = {

	init: (replay, callback) ->
		 #console.log('in bundle init');

		React = require 'react'
		@routes = require './routes'
		@routes.init(replay, callback)
}

module.exports = bundle;