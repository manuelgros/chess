# frozen_string_literal: true

# Class for single ChessPiece
class ChessPiece
  attr_reader :type, :movement, :range, :color, :board

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
end
