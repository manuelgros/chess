# frozen_string_literal: true

# EmptySquare Class to represent empty field on the board
class EmptySquare
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def position
    board.squares.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  def color
    :none
  end

  def type
    :empty
  end

  def any_moves?
    false
  end

  def enemy?
    false
  end
end
