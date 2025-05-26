# frozen_string_literal: true

# Chess_board class
class ChessBoard
  attr_reader :squares

  def initialize
    @squares = create_square_array
  end

  def create_square_array
    Array.new(8) { Array.new(8) { EmptySquare.new } }
  end

  def setup_ranks(player)
    # sort_ranks_for_start brings army array into right order
    # returns array with sorted pieces; major rank is idex 0 to 7, pawns 8 to 16
    sorted_army = player.sort_ranks_for_start
    starting_rows = player.color.eql?(:white) ? [0, 1] : [7, 6] # decides side of board depending on color
    @squares[starting_rows[0]] = sorted_army[0..7] # major rank (root, knight etc.)
    @squares[starting_rows[1]] = sorted_army[8..15] # pawn rank
  end

  def includes_coordinates?(coord)
    x_coord = coord[0]
    y_coord = coord[1]
    return true if x_coord.between?(0, 7) && y_coord.between?(0, 7)

    false
  end

  def select_square(coord_arr)
    @squares[coord_arr[0]][coord_arr[1]]
  end
end
