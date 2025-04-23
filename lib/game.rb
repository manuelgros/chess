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
    @player_one = Player.new(:white)
    @player_two = Player.new(:black)
  end

  def setting_up_ranks(player)
    sorted_army = player.army.sort_ranks_for_start
    # returns array with sorted pieces; major rank is idex 0 to 7, pawns 8 to 16
    starting_rows = player.color.eql?(:white) ? [0, 1] : [7, 6]
    @board[starting_rows[0]] = sorted_army[0..7]
    @board[starting_rows[1]] = sorted_army[8..15]
  end

  def setup_board
    setting_up_ranks(player_one)
    setting_up_ranks(player_two)
    puts board
  end
end
