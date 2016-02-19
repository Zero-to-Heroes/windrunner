React = require 'react'
Card = require './card'
DecklistCard = require './decklistcard'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'
_ = require 'lodash'
{subscribe} = require '../../../../subscription'

class DeckList extends React.Component
	componentDidMount: ->


	render: ->
		if @props.replay.currentPick > 1
			# Build the decklist
			decklist = {}

			# The current pick is not done yet, and we have an offset of 1 because of hero pick
			for i in [0..@props.replay.currentPick - 2]
				card = @props.replay.pickedCards[i]
				if !decklist[card]
					decklist[card] = 
						entity: @props.replay.cardUtils.getCard(card)
						number: 1
				else
					decklist[card].number++

			# Sort the cards according to cost, then alphabetical order
			# First create an array
			cards = []
			for k, v of decklist
				cards.push v

			# Now sort that array
			console.log 'sorting deck list', cards
			sorted = _.sortBy cards, (item) ->
				return [item.entity.cost, item.entity.name]
			console.log '\tsorted', sorted


			cardImages = sorted.map (card) ->
				<DecklistCard card={card.entity} key={card.entity.id} count={card.number} />

		return 	<div className="decklist">
					{cardImages}
				</div>

module.exports = DeckList
