# frozen_string_literal: true

# Chess_board class
class ChessBoard
  attr_reader :squares

  def initialize
    @squares = create_squares
  end

  def create_squares
    Array.new(8) { Array.new(8) }
  end

  def includes_coordinates?(coord)
    return true if @squares[coord[0]].size >= coord[1]

    false
  end
end
