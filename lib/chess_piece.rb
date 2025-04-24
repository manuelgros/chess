# frozen_string_literal: true

# Class for single ChessPiece
class ChessPiece
  attr_reader :type, :movement, :range

  def initialize(color, type, hash)
    @color = color
    @type = type
    @movement = hash[:moves]
    @range = hash[:range]
  end

  def find_position(board)
    board.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  def validate_move; end

  def move_piece; end
end
