React = require 'react'
Card = require './card'
ReactCSSTransitionGroup = require 'react-addons-css-transition-group'
_ = require 'lodash'
{subscribe} = require '../../../../subscription'

class ChosenHero extends React.Component
	componentDidMount: ->
		cards = @props.replay.cardUtils.jsonDatabase
		@heroCards = _.filter cards, (o) -> 
			return o.type == 'Hero' and o.playerClass and o.set == 'Core'


	render: ->
		replay = @props.replay

		return null unless replay.pickedHero and replay.currentPick > 0

		# console.log 'rendering hero', replay.pickedHero
		card = _.filter @heroCards, (o) -> 
				o.playerClass.toLowerCase() == replay.pickedHero.toLowerCase()
		card = card[0]

		art = "https://s3.amazonaws.com/com.zerotoheroes/plugins/hearthstone/allCards/#{card.cardImage}"

		style =
			backgroundImage: "url(#{art})"
		cls = "hero-card game-card"

		if @props.className
			cls += " " + @props.className

		return  <div className="chosen-hero">
			<div className={cls}>
				<div className="art" style={style}></div>
			</div>
		</div>


module.exports = ChosenHero
