# frozen_string_literal: true

# BUG: PAWNS CAN ALSO CAPTURE PIECE FRONTAL

# Subclass Pawn
class Pawn < ChessPiece
  # adjusted getter methods - BEGIN
  def range
    first_move? ? @range[:start] : @range[:regular]
  end

  def movement
    @movement[color][:move].concat(attack_moves(@movement[color][:capture]))
  end

  def first_move?
    start_row = color == :white ? 1 : 6
    position[0] == start_row
  end
  # adjusted getter methods - END

  # returns array with coordinated if target is enemy
  def attack_moves(attack_direction)
    attack_direction.select do |direction|
      destination = board.next_square(position, direction)
      next unless board.includes_coordinates?(destination)

      target = @board.select_square(destination)
      enemy?(target)
    end
  end
end
