# frozen_string_literal: true

require 'player'
require 'chess_board'
require 'messages'

# Class for Game Logic
class GameLogic
  def initialize
    @board = ChessBoard.new
    @player_one = Player.new(1, 'white')
    @player_two = Player.new(2, 'black')
  end
end
