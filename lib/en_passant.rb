# frozen_string_literal: true

# Main module for the En-Passant feature
module EnPassant
  def self.included(base)
    case base.name
    when 'Pawn'
      base.include(EnPassantPawn)
    when 'EmptySquare'
      base.include(EnPassantEmptySquare)
    when 'Army'
      base.include(EnPassantArmy)
    end
  end
end

# Submodule for EnPassant, including all methods in Pawn class
module EnPassantPawn
  def double_step?(destination)
    (destination[0] - position[0]).abs == 2
  end

  # method changes the color of EmptySquare object that is being jumped to own color. It will then
  # be registered as variable target at opponents next turn.
  def mark_en_passant
    jumped_square = board.select_square(board.next_square(position, @movement[color][:move][0]))
    jumped_square.en_passant(color)
  end
end

# Submodule for EnPassant, including all methods used in EmptySquare class
module EnPassantEmptySquare
  def en_passant(color)
    @color = color
  end
end

# Submodule for EnPassant, including all methods used in Army class
module EnPassantArmy
  def reset_en_passant
    board.squares.flatten.each do |square|
      square.color = :none if square.type == :empty && square.color == color
    end
  end
end
