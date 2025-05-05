# frozen_string_literal: true

# Chess_board class
class ChessBoard
  def initialize
    @squares = create_squares
  end

  def create_squares
    Array.new(8) { Array.new(8) }
  end
end
