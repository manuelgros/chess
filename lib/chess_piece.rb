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
    @board.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  def move_piece(select_arr, dest_arr)
    @board[dest_arr[0]][dest_arr[1]] = @board[select_arr[0]][select_arr[1]]
    @board[select_arr[0]][select_arr[1]] = nil
  end
end
