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

# moved to game.rb
# def select_destination
#   print player_messages(:get_destination)
#   selection = gets.chomp.chars.map(&:to_i)
#   return selection if validate_coordinate_input(selection)

#   puts player_messages(:coord_input_error)
#   select_destination
# end

# def setup_ranks
#   # sort_ranks_for_start brings army array into right order
#   # returns array with sorted pieces; major rank is idex 0 to 7, pawns 8 to 16
#   sorted_army = @army.sort_ranks_for_start
#   starting_rows = @color.eql?(:white) ? [0, 1] : [7, 6] # decides side of board depending on color
#   @board.squares[starting_rows[0]] = sorted_army[0..7] # major rank (root, knight etc.)
#   @board.squares[starting_rows[1]] = sorted_army[8..15] # pawn rank
# end
