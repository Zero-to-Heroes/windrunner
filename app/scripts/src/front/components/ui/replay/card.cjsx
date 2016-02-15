React = require 'react'
ReactDOM = require 'react-dom'
{subscribe} = require '../../../../subscription'

class Card extends React.Component

	render: ->
		locale = if window.localStorage.language and window.localStorage.language != 'en' then '/' + window.localStorage.language else ''
		art = "https://s3.amazonaws.com/com.zerotoheroes/plugins/hearthstone/allCards#{locale}/#{@props.card.cardImage}"

		style =
			backgroundImage: "url(#{art})"
		cls = "game-card"

		if @props.className
			cls += " " + @props.className

		if @props.isPicked
			cls += " picked"


		link = '<img src="' + art + '">';
		return <div className={cls} style={style} data-tip={link} data-html={true} data-place="right" data-effect="solid" data-delay-show="100" data-class="card-tooltip">
		</div>


module.exports = Card
