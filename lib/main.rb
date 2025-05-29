# frozen_string_literal: true

# Main file to be used to run program

require_relative '../lib/chess_board'
require_relative '../lib/game'

# Run code her
game = Game.new
# game.full_match
white_pawn = game.board.select_square([1, 4])
white_pawn.move([3, 4])
black_pawn = game.board.select_square([6, 4])
black_pawn.move([4, 4])
pp white_pawn.position
pp white_pawn.valid_moves
pp white_pawn.save_moves
