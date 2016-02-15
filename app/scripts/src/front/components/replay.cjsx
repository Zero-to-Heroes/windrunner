console.log('in replay')
React = require 'react'
ReactDOM = require 'react-dom'
{ButtonGroup, Button} = require 'react-photonkit'
ReplayPlayer = require '../../replay/replay-player'

HeroPick = require './ui/replay/heropick'
ChosenHero = require './ui/replay/chosenhero'
CardPick = require './ui/replay/cardpick'
DeckList = require './ui/replay/decklist'

ReactTooltip = require("react-tooltip")
{subscribe} = require '../../subscription'
_ = require 'lodash'

class Replay extends React.Component
	constructor: (props) ->
		super(props)
		@state = replay: new ReplayPlayer(props.route.replay)

		subscribe @state.replay, 'replay-ready', =>
			#console.log 'in players-ready' 
			@forceUpdate

		@state.replay.init()

	render: ->
		replay = @state.replay

		return <div className="arena-replay">
					<ReactTooltip />
					<div className="pick-area">
						<HeroPick replay={@state.replay}/>
						<CardPick replay={@state.replay} />
					</div>
					<DeckList replay={@state.replay} />
					<ChosenHero replay={@state.replay} />
					<div className="controls">
						<Button glyph="to-start" onClick={@goPreviousPick}/>
						<span className="pick-status">p{replay.currentPick} / 30</span>
						<Button glyph="to-end" onClick={@goNextPick}/>
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
