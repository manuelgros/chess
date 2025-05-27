# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/chess_board'
require_relative '../lib/empty_square'
require_relative '../lib/game_communication'
require_relative '../lib/rendering'

# Class for Game Logic
class Game
  include GameCommunication
  include Rendering

  attr_reader :board, :player_one, :player_two
  attr_accessor :current_player

  def initialize
    @board = ChessBoard.new(self)
    @player_one = Player.new(:white, @board)
    @player_two = Player.new(:black, @board)
    @current_player = @player_one
  end

  def setup_board
    @board.setup_ranks(player_one)
    @board.setup_ranks(player_two)
  end

  # will need splitting up when more actions are added (save etc.)
  def turn
    active_piece = current_player.select_piece
    puts piece_messages(:piece_moves, active_piece)
    target = current_player.select_destination

    if active_piece.valid_moves.include?(target)
      active_piece.move(target)
      puts piece_messages(:move, active_piece)
      display_board
      return
    end

    puts piece_messages(:invalid_move, active_piece, target)

    turn
  end

  def full_match
    # script to run a full match until end conditions are met (win, draw, capitulation etc.)
    display_board
    until check_mate?
      puts game_messages(:new_turn)
      turn
      @current_player = current_player == player_one ? player_two : player_one
    end
  end

  def check_mate? # Place holder to test full_match
    false
  end
end
