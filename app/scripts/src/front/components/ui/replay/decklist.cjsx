React = require 'react'
Card = require './card'
DecklistCard = require './decklistcard'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'
_ = require 'lodash'
{subscribe} = require '../../../../subscription'

class DeckList extends React.Component
	componentDidMount: ->


	render: ->
		replay = @props.replay
		if replay.currentPick > 1
			# Build the decklist
			decklist = {}

			# The current pick is not done yet, and we have an offset of 1 because of hero pick
			for i in [0..replay.currentPick - 2]
				card = replay.pickedCards[i]
				if !decklist[card]
					decklist[card] = 
						entity: replay.cardUtils.getCard(card)
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
			pad = @pad
			sorted = _.sortBy cards, (item) ->
				# console.log '\tsorting array', item.entity.name, parseInt(item.entity.cost), pad(parseInt(item.entity.cost), 2), [pad(parseInt(item.entity.cost), 2), item.entity.name]
				# http://stackoverflow.com/questions/24111535/how-can-i-use-lodash-underscore-to-sort-by-multiple-nested-fields
				# Converts to string, then sort
				return [pad(parseInt(item.entity.cost), 2), item.entity.name]
			# console.log '\tsorted', sorted

			cardImages = sorted.map (card) ->
				<DecklistCard replay={replay} card={card.entity} key={card.entity.id} count={card.number} />

		return 	<div className="decklist">
					{cardImages}
				</div>

	pad: (n, width, z) ->
		# console.log '\t\tpadding', n, width, z
		z = z || '0'
		# console.log '\t\tz', z
		n = n + ''
		# console.log '\t\tn', n
		# console.log '\t\tresult', n.length >= width, n, (new Array(width - n.length + 1).join(z) + n), if n.length >= width then n else (new Array(width - n.length + 1).join(z) + n)
		return if n.length >= width then n else new Array(width - n.length + 1).join(z) + n


module.exports = DeckList
