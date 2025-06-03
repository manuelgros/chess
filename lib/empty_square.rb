# frozen_string_literal: true

require_relative '../lib/en_passant'

# EmptySquare Class to represent empty field on the board
class EmptySquare
  include EnPassant

  attr_reader :board
  attr_accessor :color

  def initialize(board)
    @board = board
    @color = :none
  end

  def position
    board.squares.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  # def color
  #   :none
  # end

  def type
    :empty
  end

  def valid_moves
    []
  end

  def any_moves?
    false
  end

  def enemy?
    false
  end
end
