# frozen_string_literal: true

# EmptySquare Class to represent empty field on the board
class EmptySquare
  attr_accessor :en_passant

  def initialize
    en_passant = false
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
