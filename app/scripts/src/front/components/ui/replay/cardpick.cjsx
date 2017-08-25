React = require 'react'
Card = require './card'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'
_ = require 'lodash'
{subscribe} = require '../../../../subscription'

class CardPick extends React.Component


	render: ->
		return null unless @props.replay.currentPick > 0

		detectedCards = []
		detectedCards.push @props.replay.detectedCards[@props.replay.currentPick - 1]?.Item1
		detectedCards.push @props.replay.detectedCards[@props.replay.currentPick - 1]?.Item2
		detectedCards.push @props.replay.detectedCards[@props.replay.currentPick - 1]?.Item3
		console.log 'detected cards', detectedCards

		picked = @props.replay.pickedCards[@props.replay.currentPick - 1]
		showPick = @props.showPick

		cards = detectedCards.slice(0, 3).map (entity) =>
			# card = _.filter @props.replay.cardUtils.jsonDatabase, (o) -> 
			# 	o.id == entity || o.name == entity
			cardUtils = @props.replay.cardUtils
			card = cardUtils.getCard entity
			# card = card[0]
			if card
				console.log 'resolved card', card
				<Card card={card} key={card.id} isPicked={entity == picked} showPick={showPick} cardUtils={cardUtils}/>

		return <div className="pick">
				{cards}
			</div>

module.exports = CardPick
