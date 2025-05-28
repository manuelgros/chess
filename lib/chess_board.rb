# frozen_string_literal: true

# Chess_board class
class ChessBoard
  attr_reader :squares, :side

  def initialize
    @squares = create_square_array
    @side = {
      white: Player.new(:white, self),
      black: Player.new(:black, self)
    }
    @start_row = {
      white: [0, 1],
      black: [7, 6]
    }
  end

  def create_square_array
    Array.new(8) { Array.new(8) { EmptySquare.new } }
  end

  def setup_ranks(player)
    # replaces starting rows in @squares with pre-sorted army array
    army = player.army
    start_rows = @start_row[player.color]
    @squares[start_rows[0]] = army[0..7] # major rank
    @squares[start_rows[1]] = army[8..15] # pawn rank
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
