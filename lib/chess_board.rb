# frozen_string_literal: true

# Chess_board class
class ChessBoard
  attr_reader :squares

  def initialize
    @squares = create_square_array
  end

  def create_square_array
    Array.new(8) { Array.new(8) }
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
