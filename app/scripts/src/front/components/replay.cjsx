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

	componentDidMount: ->
		subscribe @state.replay, 'replay-ready', =>
			@forceUpdate()

		window.addEventListener 'resize', @updateDimensions
		@updateDimensions()

		@state.replay.init()

	updateDimensions: =>
		if this.refs['root']
			@state.style.fontSize = this.refs['root'].offsetWidth / 50.0 + 'px'
			console.log 'built style', @state.style
			@forceUpdate()

	render: ->
		replay = @state.replay

		cls = "arena-replay"
		if replay.currentPick <= 0
			cls += " hero-selection"
		else
			cls += " pick-selection"

		return <div ref="root" className={cls} style={@state.style}>
					<ReactTooltip />
					<div className="pick-area">
						<HeroPick replay={replay}/>
						<CardPick replay={replay} />
					</div>
					<DeckList replay={replay} />
					<ChosenHero replay={replay} />
					<ManaCurve replay={replay} />
					<div className="controls-container">
						<div className="controls">
							 <button className="btn btn-default glyphicon glyphicon-step-backward" onClick={@goPreviousPick}/>
							 <button className="btn btn-default glyphicon glyphicon-step-forward" onClick={@goNextPick}/>
							 <span className="pick-status btn btn-default">p{replay.currentPick} / 30</span>
						</div>
					</div>
				</div>

	goNextPick: (e) =>
		e.preventDefault()
		@state.replay.goNextPick()
		@forceUpdate()

	goPreviousPick: (e) =>
		e.preventDefault()
		@state.replay.goPreviousPick()
		@forceUpdate()

module.exports = Replay
