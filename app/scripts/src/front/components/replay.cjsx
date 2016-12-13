console.log('in replay')
React = require 'react'
ReactDOM = require 'react-dom'
# {ButtonGroup, Button} = require 'react-photonkit'
ReplayPlayer = require '../../replay/replay-player'

HeroPick = require './ui/replay/heropick'
ChosenHero = require './ui/replay/chosenhero'
CardPick = require './ui/replay/cardpick'
DeckList = require './ui/replay/decklist'
ManaCurve = require './ui/replay/manacurve'

ReactTooltip = require("react-tooltip")
{subscribe} = require '../../subscription'
_ = require 'lodash'

class Replay extends React.Component
	constructor: (props) ->
		super(props)
		@state = replay: new ReplayPlayer(props.route.replay)
		@state.style = {}

		subscribe @state.replay, 'replay-ready', =>
			@forceUpdate()

		window.addEventListener 'resize', @updateDimensions
		@updateDimensions()

		@bindKeypressHandlers()

		@state.replay.init()

		if props.route.callback
			props.route.callback()

	bindKeypressHandlers: =>
		window.addEventListener 'keydown', (e) =>
			if @mousingover
				@handleKeyDown e

	updateDimensions: =>
		if this.refs['root']?.offsetWidth > 10
			@state.style.fontSize = this.refs['root'].offsetWidth / 50.0 + 'px'
			console.log 'built style', @state.style
			@forceUpdate()
		else 
			setTimeout @updateDimensions, 200
			

	render: ->
		replay = @state.replay

		cls = "arena-replay"
		if replay.currentPick <= 0
			cls += " hero-selection"
		else
			cls += " pick-selection"

		return <div ref="root" className={cls} style={@state.style} onMouseEnter={@onMouseEnter} onMouseLeave={@onMouseLeave}>
					<ReactTooltip />
					<div className="pick-area">
						<HeroPick replay={replay}/>
						<CardPick replay={replay} showPick={@showPick} />
						<label className="show-pick">
							<input type="checkbox" checked={@showPick} onChange={@onShowPickChange} /><span className="underlined">S</span>how pick
						</label>
					</div>
					<DeckList replay={replay} />
					<ChosenHero replay={replay} />
					<ManaCurve replay={replay} />
					<div className="controls-container">
						<div className="controls">
							<button className="btn btn-default btn-control glyphicon glyphicon-step-backward" onClick={@goPreviousPick}/>
							<button className="btn btn-default btn-control glyphicon glyphicon-step-forward" onClick={@goNextPick}/>
							<span className="pick-status btn btn-default btn-control">p{replay.currentPick} / 30</span>
						</div>
					</div>
				</div>



	handleKeyDown: (e) =>
		# console.log 'keydown', e
		switch e.code
			when 'KeyS'
				@onShowPickChange()
			when 'ArrowRight'
				@goNextPick()
			when 'ArrowLeft'
				@goPreviousPick()


	onMouseEnter: (e) =>
		# console.log 'mouse entered', e
		@mousingover = true

	onMouseLeave: (e) =>
		# console.log 'mouse left', e
		@mousingover = false


	goNextPick: (e) =>
		e?.preventDefault()
		@state.replay.goNextPick()
		@forceUpdate()

	goPreviousPick: (e) =>
		e?.preventDefault()
		@state.replay.goPreviousPick()
		@forceUpdate()

	onShowPickChange: =>
		@showPick = !@showPick
		# console.log 'showpick', @showPick
		@forceUpdate()

module.exports = Replay
