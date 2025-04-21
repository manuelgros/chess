# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/chess_board'
require_relative '../lib/messages'
require_relative '../lib/game_logic'

# Class for Game Logic
class Game
  include GameLogic
  attr_reader :board, :player_one, :player_two

  def initialize
    @board = Array.new(8) { Array.new(8) }
    @player_one = Player.new(1, :white)
    @player_two = Player.new(2, :black)
  end

  def setting_up_game
    setting_up_ranks(@player_one)
    setting_up_ranks(@player_two)
  end
end
