# frozen_string_literal: true

# Main file to be used to run program

require_relative '../lib/chess_board'
require_relative '../lib/game'

# Run code her
game = Game.new
game.full_match

# puts game.current_player.class.name
# puts game.board.select_square([1, 1]).class.name
# puts game.board.select_square([2, 1]).class.name
