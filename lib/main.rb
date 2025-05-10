# frozen_string_literal: true

# Main file to be used to run program

require_relative '../lib/chess_board'
require_relative '../lib/game'

# Run code her
game = Game.new
game.setup_board
puts "#{game.board.select_square([7, 0]).color} #{game.board.select_square([7, 0]).type}"
puts "#{game.board.select_square([0, 0]).color} #{game.board.select_square([0, 0]).type}"
pp game.board.select_square([1, 0]).position
pp game.board.select_square([1, 0]).direction
game.board.select_square([1, 0]).move([2, 0])
puts game.board.select_square([2, 0])
puts game.board.select_square([1, 0])
