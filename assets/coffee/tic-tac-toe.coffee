class TicTacToe
	constructor: ()->
		@setUpBoard()

	setUpBoard: ()->
		# Create canvas
		@canvas  = document.getElementById('tic_tac_toe')
		@context = @canvas.getContext('2d')

		# Nice things to have
		@$canvas = $('#tic_tac_toe')
		@height = @$canvas.height()
		@width  = @$canvas.width()

		@canvas.setAttribute('height', @height)
		@canvas.setAttribute('width', @width)

		# Draw the board
		@drawBoard()
	
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

		# Bottom horizontal line

		# Left vertical line

		# Right vertical line

game = new TicTacToe
