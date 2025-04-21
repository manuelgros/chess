# frozen_string_literal: true

# Class for single ChessPiece
class ChessPiece
  attr_reader :type, :movement, :range

  def initialize(color, array)
    @color = color
    @type = array[0]
    @movement = array[2]
    @range = array[3]
  end
end
