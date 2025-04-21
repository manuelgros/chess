# frozen_string_literal: true

require 'player'
require 'chess_board'
require 'messages'
require 'game_logic'

# Class for Game Logic
class Game
  include GameLogic
  attr_reader :board, :player_one, :player_two

  def initialize
    @board = ChessBoard.new
    @player_one = Player.new(1, :white)
    @player_two = Player.new(2, :black)
  end

  def setting_up_game
    setting_up_ranks(@player_one)
    setting_up_ranks(@player_two)
  end
end
