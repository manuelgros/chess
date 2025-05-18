# frozen_string_literal: true

require_relative '../lib/messages'
require_relative '../lib/chess_piece'
require_relative '../lib/chess_piece_database'

# Player Class
class Player
  include Messages
  include ChessPieceDatabase

  attr_reader :name, :color, :army

  def initialize(color, board)
    @color = color
    @name = ask_name
    @board = board
    @army = create_full_set(@color, chess_piece_database, @board)
  end

  def ask_name
    print player_messages(:get_name)
    gets.chomp
  end

  def ask_coordinates
    selection = gets.chomp.chars.map(&:to_i)
    if validate_coordinate_input(selection) # && !@board.select_square(selection).nil?
      selection
    else
      puts player_messages(:coord_input_error) # confusing, need better messages for different scenarios
      select_coordinates
    end
  end

  def select_piece
    puts player_messages(:get_selection) # maybe more specific to select piece
    selected_piece = @board.select_square(ask_coordinates)
    return selected_piece unless selected_piece.nil? || !selected_piece.any_moves?

    puts 'There are no moves for your selection'
    select_piece
  end

  def select_destination
    puts player_messages(:get_destination)
    destination = ask_coordinates
    target = @board.select_square(destination)
    return destination if target.nil? || target.color != @color

    puts 'Invalid target'
    select_destination
  end

  def create_chess_piece(color, typ, movement, range, board)
    ChessPiece.new(color, typ, movement, range, board)
  end

  def create_full_set(color, piece_database, board)
    full_set = []
    piece_database.each_pair do |type, database|
      database[:amount].times do
        full_set << create_chess_piece(color, type, database[:moves], database[:range], board)
      end
    end
    full_set
  end

  def sort_ranks_for_start
    expected_order = setup_order
    expected_order.map do |type|
      @army.delete_at(@army.find_index { |chess_piece| chess_piece.type == type })
    end
  end
end
