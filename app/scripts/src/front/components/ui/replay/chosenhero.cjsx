React = require 'react'
Card = require './card'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'
_ = require 'lodash'
{subscribe} = require '../../../../subscription'

class ChosenHero extends React.Component
	componentDidMount: ->
		cards = @props.replay.cardUtils.jsonDatabase
		@heroCards = _.filter cards, (o) -> 
			return o.type == 'Hero' and o.playerClass and o.set == 'Basic'


	render: ->
		replay = @props.replay

		return null unless replay.pickedHero and replay.currentPick > 0

		card = _.filter @heroCards, (o) -> 
				o.playerClass.toLowerCase() == replay.pickedHero.toLowerCase()
		card = card[0]

		art = "https://s3.amazonaws.com/com.zerotoheroes/plugins/hearthstone/allCards/#{card.cardImage}"

		style =
			background: "url(#{art}) top left no-repeat"
			backgroundSize: '100% auto'
		cls = "hero-card game-card"

		if @props.className
			cls += " " + @props.className

		return 	<div className={cls} style={style}></div>


module.exports = ChosenHero
