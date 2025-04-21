# frozen_string_literal: true

# Chess_board class
class ChessBoard
  def initialize
    @square = create_board_squares
  end

  def create_board_squares
    Array.new(8) { Array.new(8) }
  end
end
