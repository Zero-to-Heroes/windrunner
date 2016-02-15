React = require 'react'
ReactDOM = require 'react-dom'
{subscribe} = require '../../../../subscription'

class DecklistCard extends React.Component

	render: ->
		locale = if window.localStorage.language and window.localStorage.language != 'en' then '/' + window.localStorage.language else ''
		art = "https://s3.amazonaws.com/com.zerotoheroes/plugins/hearthstone/allCards#{locale}/#{@props.card.cardImage}"

		style =
			backgroundImage: "url(#{art})"
		cls = "decklist-card"

		if @props.className
			cls += " " + @props.className


		link = '<img src="' + art + '">';

		bgCls = "bg"
		if @props.count > 1
			count = <span className="count">{@props.count}</span>
			bgCls += " number"

		costSrc = "https://s3.amazonaws.com/com.zerotoheroes/plugins/hearthstone/allCards/mana/#{@props.card.cost}.png"
		return 	<div className={cls} data-tip={link} data-html={true} data-place="right" data-effect="solid" data-delay-show="100" data-class="card-tooltip">
					<img src={costSrc} className="cost"></img>
					<span className="name">{@props.card.name}</span>
					<span className={bgCls} style={style}>
						<div></div>
					</span>
					{count}
				</div>


module.exports = DecklistCard
