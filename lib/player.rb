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
    @army = ChessArmy.new(color)
  end

  def ask_player_name
    print player_messages(:get_name)
    gets.chomp
  end

  def select_pice
    print player_messages(:get_selection)
    selection = gets.chomp.digits
    if validate_input(selection) && !@board[selection[0]][selection[1]].nil?
      selection
    else
      puts game_messages(:input_error)
      select_piece
  end

  def select_destination
    print "Where?"
    selection = gets.chomp.digits
    return selection if validate_input(selection)

    puts game_messages(:input_error)
    select_destination
  end

  def validate_input(input_arr)
    input_arr.size == 2 && input_arr.all?(&Integer.method(:===))
  end

  def setup_ranks
    sorted_army = @army.sort_ranks_for_start
    # returns array with sorted pieces; major rank is idex 0 to 7, pawns 8 to 16
    starting_rows = @color.eql?(:white) ? [0, 1] : [7, 6]
    @board[starting_rows[0]] = sorted_army[0..7]
    @board[starting_rows[1]] = sorted_army[8..15]
  end

end
