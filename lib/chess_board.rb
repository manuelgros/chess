# frozen_string_literal: true

# Chess_board class
class ChessBoard
  attr_reader :squares, :side, :start_rows

  def initialize
    @squares = create_square_array
    @side = {
      white: Army.new(:white, self),
      black: Army.new(:black, self)
    }
    @start_rows = {
      white: [0, 1],
      black: [7, 6]
    }
    setup_board
  end

  def create_square_array
    Array.new(8) { Array.new(8) { EmptySquare.new(self) } }
  end

  def pawn_rank(color)
    side[color].army.select { |piece| piece.type == :pawn }
  end

  def major_rank(color)
    side[color].army.reject { |piece| piece.type == :pawn }
  end

  def setup_side(color)
    # replaces starting rows in @squares with pre-sorted army array
    @squares[start_rows[color][0]] = major_rank(color) # major rank
    @squares[start_rows[color][1]] = pawn_rank(color) # pawn rank
  end

  def setup_board
    side.each_key { |color| setup_side(color) }
  end

  def includes_coordinates?(coord)
    true if coord.none?(&:negative?) && coord.all? { |num| num.between?(0, 7) }
  end

  def select_square(coord_arr)
    @squares[coord_arr[0]][coord_arr[1]]
  end

  def change_square(coord, object)
    @squares[coord[0]][coord[1]] = object
  end

  def next_square(current_pos, direction)
    current_pos.zip(direction).map { |coord, movement| coord + movement }
  end
end
