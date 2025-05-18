# frozen_string_literal: true

require_relative '../lib/messages'
require_relative '../lib/chess_army'

# Player Class
class Player
  include Messages
  attr_reader :name, :color, :army

  def initialize(color, board)
    @color = color
    @name = ask_player_name
    @board = board
    @army = ChessArmy.new(@color, @board)
  end

  def ask_player_name
    print player_messages(:get_name)
    gets.chomp
  end

  def select_coordinates
    selection = gets.chomp.chars.map(&:to_i)
    if validate_coordinate_input(selection) # && !@board.select_square(selection).nil?
      selection
    else
      puts player_messages(:coord_input_error) # confusing, need better messages for different scenarios
      select_coordinates
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
end
