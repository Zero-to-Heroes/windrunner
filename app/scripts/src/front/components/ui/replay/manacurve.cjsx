React = require 'react'
ReactDOM = require 'react-dom'
{subscribe} = require '../../../../subscription'

class ManaCurve extends React.Component

	render: ->

		return null unless @props.replay.currentPick > 1

		costs = {}
		for i in [0..@props.replay.currentPick - 2]
				cardId = @props.replay.pickedCards[i]
				card = @props.replay.cardUtils.getCard(cardId)
				cost = Math.min(7, card.cost)
				if costs[cost]
					costs[cost]++
				else 
					costs[cost] = 1

		# Find the highest
		highestNumber = -1
		costWithHighest = -1
		for k, v of costs
			if v > highestNumber
				highestNumber = v
				costWithHighest = k

		highestNumber = Math.max highestNumber, 4

		return 	<div className="mana-curve">
					<div className="mana" style={ height: (costs[0] or 0) * 100.0 / highestNumber + '%' } data-tip={(costs[0] + ' cards') or 'no card'} data-place="right" data-effect="solid" data-delay-show="100" />
					<div className="mana" style={ height: (costs[1] or 0) * 100.0 / highestNumber + '%' } data-tip={(costs[1] + ' cards') or 'no card'} data-place="right" data-effect="solid" data-delay-show="100" />
					<div className="mana" style={ height: (costs[2] or 0) * 100.0 / highestNumber + '%' } data-tip={(costs[2] + ' cards') or 'no card'} data-place="right" data-effect="solid" data-delay-show="100" />
					<div className="mana" style={ height: (costs[3] or 0) * 100.0 / highestNumber + '%' } data-tip={(costs[3] + ' cards') or 'no card'} data-place="right" data-effect="solid" data-delay-show="100" />
					<div className="mana" style={ height: (costs[4] or 0) * 100.0 / highestNumber + '%' } data-tip={(costs[4] + ' cards') or 'no card'} data-place="right" data-effect="solid" data-delay-show="100" />
					<div className="mana" style={ height: (costs[5] or 0) * 100.0 / highestNumber + '%' } data-tip={(costs[5] + ' cards') or 'no card'} data-place="right" data-effect="solid" data-delay-show="100" />
					<div className="mana" style={ height: (costs[6] or 0) * 100.0 / highestNumber + '%' } data-tip={(costs[6] + ' cards') or 'no card'} data-place="right" data-effect="solid" data-delay-show="100" />
					<div className="mana" style={ height: (costs[7] or 0) * 100.0 / highestNumber + '%' } data-tip={(costs[7] + ' cards') or 'no card'} data-place="right" data-effect="solid" data-delay-show="100" />
				</div>




module.exports = ManaCurve
