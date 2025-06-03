# frozen_string_literal: true

# Main file to be used to run program

require_relative '../lib/chess_board'
require_relative '../lib/game'

# Run code her
game = Game.new
game.full_match

# pp game.board.select_square([1, 1]).movement
# game.board.select_square([6, 1]).move([2, 2])
# puts game.board.select_square([2, 2]).class.name
# pp game.board.select_square([1, 1]).movement
# game.board.select_square([2, 2]).move([6, 1])
# puts game.board.select_square([2, 2]).class.name
# pp game.board.select_square([1, 1]).movement
# game.board.select_square([6, 1]).move([2, 2])
# puts game.board.select_square([2, 2]).class.name
# pp game.board.select_square([1, 1]).movement
# game.board.select_square([2, 2]).move([6, 1])
# puts game.board.select_square([2, 2]).class.name
# pp game.board.select_square([1, 1]).movement
