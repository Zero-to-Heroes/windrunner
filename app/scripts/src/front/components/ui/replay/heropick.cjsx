React = require 'react'
Card = require './card'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'
_ = require 'lodash'
{subscribe} = require '../../../../subscription'

class HeroPick extends React.Component

	componentDidMount: ->
		heroes = @props.replay.detectedHeroes
		cards = @props.replay.cardUtils.jsonDatabase
		@heroCards = _.filter cards, (o) -> 
			return o.type == 'Hero' and o.playerClass and o.set == 'Basic'
		console.log 'hero cards', @heroCards

		@forceUpdate()


	render: ->
		return null unless @props.replay.currentPick is 0 and @heroCards

		console.log 'detectedHeroes', @props.replay.detectedHeroes

		heroCards = @heroCards
		picked = @props.replay.pickedHero
		cards = @props.replay.detectedHeroes.slice(0, 3).map (entity) =>
			card = _.filter heroCards, (o) -> 
				entity and o.playerClass.toLowerCase() == entity.toLowerCase()
			if card.length > 0
				card = card[0]
				<Card card={card} key={card.id} className="hero-card" isPicked={entity == picked} />

		return <ReactCSSTransitionGroup component="div" className="pick"
					transitionName="animate" transitionEnterTimeout={700}
					transitionLeaveTimeout={700}>
				{cards}
			</ReactCSSTransitionGroup>

module.exports = HeroPick
