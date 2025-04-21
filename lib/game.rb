# frozen_string_literal: true

require 'player'
require 'chess_board'
require 'messages'
require 'game_logic'

# Class for Game Logic
class Game
  def initialize
    @board = ChessBoard.new
    @player_one = Player.new(1, :white)
    @player_two = Player.new(2, :black)
  end
end
