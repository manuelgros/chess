# frozen_string_literal: true

# Main file to be used to run program

require_relative '../lib/chess_board'
require_relative '../lib/game'

# Run code her
Game.start_game

# ====== Pawn Promote Test =========
# game.board.select_square([1, 1]).move([6, 1])
# game.board.change_square([7, 1], EmptySquare.new(game.board))
# game.board.select_square([6, 1]).move([7, 1])
# puts game.board.select_square([7, 1]).type
