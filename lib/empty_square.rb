# frozen_string_literal: true

# EmptySquare Class to represent empty field on the board
class EmptySquare
  def color
    :none
  end

  def type
    :empty
  end

  def empty?
    true
  end

  def any_moves?
    false
  end
end
