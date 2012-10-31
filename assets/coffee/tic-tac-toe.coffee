class TicTacToe
	constructor: ()->
		@setUpBoard()
		@addEventListeners()

	setUpBoard: ()->
		@canvas = document.getElementById('tic_tac_toe')
		@context = @canvas.getContext('2d')

game = new TicTacToe
