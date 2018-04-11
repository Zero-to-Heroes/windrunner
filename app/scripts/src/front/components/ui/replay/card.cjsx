React = require 'react'
ReactDOM = require 'react-dom'
{subscribe} = require '../../../../subscription'

class Card extends React.Component

	render: ->
		locale = if window.localStorage.language and window.localStorage.language != 'en' then '/' + window.localStorage.language else ''

		card = @props.card

		art = "http://static.zerotoheroes.com/hearthstone/fullcard/en/256/#{card.cardImage}"

		style =
			backgroundImage: "url(#{art})"
		cls = "game-card"

		if @props.className
			cls += " " + @props.className

		imageCls = 'art'
		if card.set?.toLowerCase() is 'gangs'
			# console.log '\tgangs card'
			imageCls += ' quick-fix'

		if card.type is 'Hero'
			imageCls += ' hero-card'

		if @props.isPicked and @props.showPick
			overlay = <span className="glyphicon glyphicon-ok picked"></span>


		link = '<img src="' + art + '">';
		return <div className={cls} data-tip={link} data-html={true} data-place="right" data-effect="solid" data-delay-show="100" data-class="card-tooltip">
			<div className={imageCls} style={style}></div>
			{overlay}
		</div>


module.exports = Card
