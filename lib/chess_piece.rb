# frozen_string_literal: true

# Class for single ChessPiece
class ChessPiece
  attr_reader :color, :type, :movement, :range, :board

  def initialize(color, type, hash, board)
    @color = color
    @type = type
    @movement = hash[:moves]
    @range = hash[:range]
    @board = board
  end

  def position
    @board.squares.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  # Takes array with coordinates. Determines destination on board array of ChessBoard
  def move(destination)
    current_position = position
    @board.squares[destination[0]][destination[1]] = @board.squares[current_position[0]][current_position[1]]
    @board.squares[current_position[0]][current_position[1]] = nil
  end

  # Takes a direction as array (exp. [1, 0] = one square up) and calculates the full range by returning
  # array with all valid fields that could be selected for the destination for certain piece
  def reach(current_position, direction)
    reachable = []
    start = current_position
    @range.times do
      next_square = start.zip(direction).map { |coord, movement| coord + movement }
      reachable << next_square if @board.includes_coordinates?(next_square)
      start = next_square

      # break unless board.select_square(current_position).nil?
    end
    reachable
  end

  # Takes all directions arrays from @movement and calls range for each
  def valid_moves
    current_position = position
    @movement.each_with_object([]) do |direction, valid_moves|
      valid_moves.concat(reach(current_position, direction))
    end
  end
end
