# frozen_string_literal: true

require_relative '../lib/army'
require_relative '../lib/chess_board'
require_relative '../lib/empty_square'
require_relative '../lib/game_communication'
require_relative '../lib/rendering'

# Class for Game Logic
class Game
  include GameCommunication
  include Rendering

  attr_reader :board, :white_army, :black_army
  attr_accessor :current_player

  def initialize
    @board = ChessBoard.new
    @white_army = board.side[:white]
    @black_army = board.side[:black]
    @current_player = @white_army
  end

  # will need splitting up when more actions are added (save etc.)
  def turn
    active_piece = current_player.select_piece
    puts piece_messages(:piece_moves, active_piece)
    display_board(active_piece.save_moves)
    target = current_player.select_destination

    if active_piece.save_moves.include?(target)
      active_piece.move(target)
      # puts piece_messages(:move, active_piece)
      display_board
      return
    end

    puts piece_messages(:invalid_move, active_piece)

    turn
  end

  def change_current_player
    @current_player = current_player == white_army ? black_army : white_army
  end

  def full_match
    # script to run a full match until end conditions are met (win, draw, capitulation etc.)
    display_board
    loop do
      puts game_messages(:new_turn)
      turn
      break if check_mate?

      change_current_player
    end
    puts "#{current_player.player_name} won!"
  end

  def check_mate? # Place holder to test full_match
    current_player.opponent.check_mate?
  end
end
