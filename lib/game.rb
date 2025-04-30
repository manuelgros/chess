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
    @player_one = Player.new(:white, @board)
    @player_two = Player.new(:black, @board)
  end

  def setup_board
    player_one.setup_ranks
    player_two.setup_ranks
    puts board
  end
end
