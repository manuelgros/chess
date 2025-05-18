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

  def setup_ranks(player)
    # sort_ranks_for_start brings army array into right order
    # returns array with sorted pieces; major rank is idex 0 to 7, pawns 8 to 16
    sorted_army = player.sort_ranks_for_start
    starting_rows = player.color.eql?(:white) ? [0, 1] : [7, 6] # decides side of board depending on color
    @board.squares[starting_rows[0]] = sorted_army[0..7] # major rank (root, knight etc.)
    @board.squares[starting_rows[1]] = sorted_army[8..15] # pawn rank
  end

  def setup_board
    setup_ranks(player_one)
    setup_ranks(player_two)
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

  # def select_piece
  #   puts player_messages(:get_selection) # maybe more specific to select piece
  #   selected_piece = @board.select_square(current_player.ask_coordinates)
  #   return unless selected_piece.nil? || !selected_piece.any_moves?

  #   puts 'There are no moves for your selection'
  #   select_piece
  # end

  # def select_destination
  #   puts player_messages(:get_destination)
  #   destination = current_player.ask_coordinates
  #   target = @board.select_square(destination)
  #   return destination if target.nil? || target.color != current_player.color

  #   puts 'Invalid target'
  #   select_destination
  # end

  def full_match
    # script to run a full match until end conditions are met (win, draw, capitulation etc.)
  end
end
