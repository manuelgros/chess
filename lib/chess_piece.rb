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

  def find_position
    @board.squares.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  # Needs ADJUSTMENT after transfer to this class!
  def move_piece(select_arr, dest_arr)
    @board.squares[dest_arr[0]][dest_arr[1]] = @board.squares[select_arr[0]][select_arr[1]]
    @board.squares[select_arr[0]][select_arr[1]] = nil
  end

  # Takes a direction as array (exp. [1, 0] = one square up) and calculates the full range by returning
  # array with all valid fields that could be selected for the destination for certain piece
  def calc_range(current_position, direction)
    full_range = []
    @range.times do
      current_position = [
        (current_position[0] + direction[0]), (current_position[1] + direction[1])
      ]
      full_range << current_position if @board.includes_coordinates?(current_position)

      break unless board.select_square(current_position).nil?
    end
    full_range
  end

  # Takes all directions arrays from @movement and calls calc_range for each
  def find_paths
    current_position = find_position
    @movement.each_with_object([]) do |direction, valid_moves|
      valid_moves << calc_range(current_position, direction)
      valid_moves.flatten!(1)
    end
  end
end
