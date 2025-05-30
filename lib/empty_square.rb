# frozen_string_literal: true

# EmptySquare Class to represent empty field on the board
class EmptySquare
  attr_accessor :board, :en_passant

  def initialize(board)
    @board = board
    @en_passant = false
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

  def en_passant?
    en_passant
  end

  def type
    :empty
  end

  def any_moves?
    false
  end

  def enemy?
    en_passant
  end
end
