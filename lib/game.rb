# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/chess_board'
require_relative '../lib/messages'

# Class for Game Logic
class Game
  include Messages

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

  # def single_turn
  #   selected_piece = @board.select_square(current_player.select_piece)
  #   unless selected_piece.any_moves?
  #     puts 'No moves for that piece'
  #     single_turn
  #   end
  #   target = current_player.select_destination
  #   # puts game_messages(:capture) unless @board.select_square(destination).nil?
  #   if selected_piece.valid_moves.include?(target)
  #     selected_piece.move(target)
  #   else
  #     puts
  #   end
  # end

  def full_match
    # script to run a full match until end conditions are met (win, draw, capitulation etc.)
  end
end
