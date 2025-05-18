# frozen_string_literal: true

# Class for single ChessPiece
class ChessPiece
  attr_reader :color, :type, :movement, :range, :board

  def initialize(color, type, movement, range, board)
    @color = color
    @type = type
    @movement = movement
    @range = range
    @board = board
  end

  def position
    @board.squares.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  # Takes coordinate array ([3, 5] = board[3][5]). It transfers ChessPiece object from current position to
  # destination
  def move(destination)
    current_position = position # method to find own position
    @board.squares[destination[0]][destination[1]] = @board.squares[current_position[0]][current_position[1]]
    @board.squares[current_position[0]][current_position[1]] = nil
  end

  # takes direction array (exp [1, 0] = up) and collects all coordinates in range from current position of piece
  # returns array with all valid coordinates in a single direction.
  # Loop breaks BEFORE adding coordinate if field is used by friendly piece and AFTER if enemy
  def reach(current_position, direction)
    reachable = []
    start = current_position
    @range.times do
      next_square = start.zip(direction).map { |coord, movement| coord + movement }
      break if next_square.any?(&:negative?) # prevent negative index selection in array

      if board.select_square(next_square).nil? && @board.includes_coordinates?(next_square)
        reachable << next_square
        start = next_square
      else
        reachable << next_square if board.select_square(next_square).color != @color

        break
      end
    end
    reachable
  end

  # Takes all directions arrays from @movement and calls range for each. Returns array with all valid coordinates
  def valid_moves
    current_position = position
    @movement.each_with_object([]) do |direction, valid_moves|
      valid_moves.concat(reach(current_position, direction))
    end
  end

  def any_moves?
    return false if valid_moves.empty?

    true
  end
end
