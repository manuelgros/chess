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
    position[0] == board.start_rows[color][1]
  end

  def moving_straight?(direction)
    direction[1].zero?
  end
  # adjusted getter methods - END

  # Adjusted reach(); doesn't allow to take enemy piece with normal movement
  # Pawn is only allowed to take enemy with diagonally moves.
  def reach(direction)
    current_pos = position
    reachable = []

    range.times do
      current_pos = board.next_square(current_pos, direction)
      break unless board.includes_coordinates?(current_pos)

      target = @board.select_square(current_pos)

      if target.type == :empty
        reachable << current_pos
      else
        reachable << current_pos if enemy?(target) && !moving_straight?(direction)
        break
      end
    end
    reachable
  end

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
