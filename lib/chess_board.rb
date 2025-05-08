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
    return true if @squares[coord[0]].size >= coord[1]

    false
  end

  def select_square(coord_arr)
    @squares[coord_arr[0]][coord_arr[1]]
  end
end
