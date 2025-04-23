# frozen_string_literal: true

# Main file to be used to run program

require_relative '../lib/chess_board'
require_relative '../lib/game'

# Run code her
game = Game.new
game.setup_board
puts game.board[7][0].type
puts game.board[0][0].type
