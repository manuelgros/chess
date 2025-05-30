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

      break unless target.type == :empty

      reachable << current_pos
    end
    reachable
  end

  def double_step?(destination)
    destination[0] == position[0] + 2
  end

  def move(destination)
    if double_step?(destination)
      jumped_coord = [destination[0], (destination[1] - 1)]
      jumped_square = board.select_square(jumped_coord)
      jumped_square.en_passant == true if jumped_square.type == :empty
    end
    super(destination)
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
