# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/chess_board'
require_relative '../lib/messages'
require_relative '../lib/game_logic'

# Class for Game Logic
class Game
  include GameLogic
  attr_reader :board, :player_one, :player_two, :current_player

  def initialize
    @board = ChessBoard.new
    @player_one = Player.new(:white, @board)
    @player_two = Player.new(:black, @board)
    @current_player = @player_one
  end

  def setup_board
    player_one.setup_ranks
    player_two.setup_ranks
    puts board
  end

  def single_turn
    # script for a full player turn
  end

  def full_match
    # script to run a full match until end conditions are met (win, draw, capitulation etc.)
  end
end
