React = require 'react'
Card = require './card'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'
_ = require 'lodash'
{subscribe} = require '../../../../subscription'

class CardPick extends React.Component


	render: ->
		return null unless @props.replay.currentPick > 0

		detectedCards = []
		detectedCards.push @props.replay.detectedCards[@props.replay.currentPick - 1].Item1
		detectedCards.push @props.replay.detectedCards[@props.replay.currentPick - 1].Item2
		detectedCards.push @props.replay.detectedCards[@props.replay.currentPick - 1].Item3

		picked = @props.replay.pickedCards[@props.replay.currentPick - 1]

		cards = detectedCards.slice(0, 3).map (entity) =>
			card = _.filter @props.replay.cardUtils.jsonDatabase, (o) -> 
				o.id == entity
			card = card[0]
			<Card card={card} key={card.id} isPicked={entity == picked} />

		return <div className="pick">
				{cards}
			</div>

module.exports = CardPick
