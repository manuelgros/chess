# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/chess_board'
require_relative '../lib/game_communication'

# Class for Game Logic
class Game
  include GameCommunication

  attr_reader :board, :player_one, :player_two, :current_player

  def initialize
    @board = ChessBoard.new
    @player_one = Player.new(:white, @board)
    @player_two = Player.new(:black, @board)
    @current_player = @player_one
  end

  def setup_board
    @board.setup_ranks(player_one)
    @board.setup_ranks(player_two)
    puts board
  end

  def turn
    active_piece = current_player.select_piece
    target = current_player.select_destination
    if active_piece.valid_moves.include?(target)
      active_piece.move(target)
      puts move_messages(:move, active_piece, target)
      return
    end

    puts move_messages(:invalid_move, active_piece, target)

    turn
  end

  def full_match
    # script to run a full match until end conditions are met (win, draw, capitulation etc.)
  end
end
