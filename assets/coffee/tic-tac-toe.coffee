EMPTY = undefined
O_PLAYER = 0
X_PLAYER = 1
TIE = 2

class TicTacToe
	constructor: (@id)->
		@canvas  = document.getElementById(@id)
		@context = @canvas.getContext('2d')

		@$canvas = $('#' + @id)
		@height  = @$canvas.height()
		@width   = @$canvas.width()
		{@x, @y} = @$canvas.position()

		@$canvas.on 'click', @captureClick

		@canvas.setAttribute('height', @height)
		@canvas.setAttribute('width',  @width)

		@symbols = (EMPTY for i in [0...9])
		@symbolCoordinates = @calculateSymbolCoordinates()
		@currentPlayer = O_PLAYER

		@drawBoard()

	announce: (text)->
		centerX = @width/2
		centerY = @height/2

		# Background
		@context.beginPath()
		@context.rect(0, centerY/2, @width, centerY)
		@context.fillStyle = '#000000'
		@context.fill()

		# Announcement
		@context.font = "#{centerY/3}px sans-serif"
		@context.textAlign = 'center'
		@context.textBaseline = 'middle'
		@context.fillStyle = '#FFFFFF'
		@context.fillText(text, centerX, centerY)

		this

	endGame: (winner)->
		@$canvas.off('click').css('cursor', 'default')
		if winner is O_PLAYER
			announcement = 'O WINS!'
		else if winner is X_PLAYER
			announcement = 'X WINS!'
		else
			announcement = 'TIE!'

		@announce(announcement)

	captureClick: (e)=>
		squareIndex = @findSquareIndex(e)

		if @symbols[squareIndex] is EMPTY
			@drawSymbol(squareIndex)
			@populateSquare(squareIndex)
			winner = @checkForWin()
			if winner isnt undefined
				@endGame(winner)

		this

	findSquareIndex: (e)=>
		[x, y] = [e.offsetX, e.offsetY]

		minI    = undefined
		minDiff = undefined

		for symbolCoordinate, i in @symbolCoordinates
			[symbolX, symbolY] = symbolCoordinate
			xDiff = Math.abs(x - symbolX)
			yDiff = Math.abs(y - symbolY)

			diff = xDiff + yDiff

			if minDiff is undefined or diff < minDiff
				minDiff = diff
				minI = i

		minI

	drawSymbol: (index)->
		[x, y] = @symbolCoordinates[index]

		thirdHeight = @height/6
		thirdWidth  = @width/6

		if @currentPlayer is X_PLAYER
			@drawX(x, y, thirdHeight, thirdWidth)
		else
			@drawO(x, y, Math.min(thirdHeight, thirdWidth) )

		this
	
	drawO: (x, y, squareSize)->
		radius = squareSize*0.75
		@context.beginPath()
		@context.arc(x, y, radius, 0, 2*Math.PI, false)
		@context.lineWidth = 3
		@context.stroke()

		this

	drawX: (x, y, height, width)->
		halfHeight = height/2
		halfWidth = width/2

		@context.beginPath()

		# Top left to bottom right
		@context.moveTo(x - halfWidth, y - halfHeight)
		@context.lineTo(x + halfWidth, y + halfHeight)

		# Bottom left to top right
		@context.moveTo(x - halfWidth, y + halfHeight)
		@context.lineTo(x + halfWidth, y - halfHeight)

		@context.lineWidth = 3
		@context.stroke()

		this

	populateSquare: (index)->
		@symbols[index] = @currentPlayer
		@currentPlayer = if @currentPlayer is X_PLAYER then O_PLAYER else X_PLAYER

		this

	checkForWin: ()->
		winner = undefined
		if (@symbols[0] isnt EMPTY and @symbols[0] is @symbols[1] and @symbols[0] is @symbols[2]) or
		   (@symbols[0] isnt EMPTY and @symbols[0] is @symbols[3] and @symbols[0] is @symbols[6]) or
		   (@symbols[0] isnt EMPTY and @symbols[0] is @symbols[4] and @symbols[0] is @symbols[8])
			winner = @symbols[0]
		else if (@symbols[2] isnt EMPTY and @symbols[2] is @symbols[4] and @symbols[2] is @symbols[6]) or
		        (@symbols[2] isnt EMPTY and @symbols[2] is @symbols[5] and @symbols[2] is @symbols[8])
			winner = @symbols[2]
		else if (@symbols[1] isnt EMPTY and @symbols[1] is @symbols[4] and @symbols[1] is @symbols[7])
			winner = @symbols[1]
		else if (@symbols[6] isnt EMPTY and @symbols[6] is @symbols[7] and @symbols[6] is @symbols[8])
			winner = @symbols[6]
		else if (@symbols[3] isnt EMPTY and @symbols[3] is @symbols[4] and @symbols[3] is @symbols[5])
			winner = @symbols[3]

		if winner is undefined
			tie = true
			for symbol in @symbols
				if symbol is EMPTY
					tie = false
			if tie is true
				winner = TIE

		winner


	calculateSymbolCoordinates: ()->
		symbolCoordinates = []

		sixthHeight = @height/6
		sixthWidth  = @width/6

		thirdHeight = sixthHeight*2
		thirdWidth = sixthWidth*2

		for i in [0...3]
			y = sixthHeight + i*thirdHeight
			for j in [0...3]
				x = sixthWidth + j*thirdWidth
				symbolCoordinates.push([x,y])

		symbolCoordinates

	drawBoard: ()->

		thirdHeight = @height/3
		thirdWidth  = @width/3

		@context.beginPath()

		# Top horizontal line
		@context.moveTo(0, thirdHeight)
		@context.lineTo(@width, thirdHeight)

		# Bottom horizontal line
		@context.moveTo(0, 2*thirdHeight)
		@context.lineTo(@width, 2*thirdHeight)

		# Left vertical line
		@context.moveTo(thirdWidth, 0)
		@context.lineTo(thirdWidth, @height)

		# Top horizontal line
		@context.moveTo(2*thirdWidth, 0)
		@context.lineTo(2*thirdWidth, @height)

		@context.stroke()

		this

game = new TicTacToe('tic_tac_toe')
