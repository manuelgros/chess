# frozen_string_literal: true

require_relative '../lib/en_passant'

# BUG: PAWNS CAN ALSO CAPTURE PIECE FRONTAL

# Subclass Pawn
class Pawn < ChessPiece
  include EnPassant
  # adjusted getter methods - BEGIN
  def range
    first_move? ? @range[:start] : @range[:regular]
  end

  def movement
    @movement[color][:move] + attack_moves(@movement[color][:capture])
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

  def move(destination)
    mark_en_passant if double_step?(destination)
    super(destination)
    execute_promotion if promote?
  end

  # basic but working promote logic. Needs additional save guards against invalid player input
  def promote?
    last_row = color == :white ? 7 : 0
    position[0] == last_row
  end

  def promote_to(type)
    new_piece = commander.create_chess_piece(type)
    board.change_square(position, new_piece)
  end

  def execute_promotion
    puts 'Your Pawn can be promoted! Which type do you choose? (queen, rook, knight, bishop):'
    type = gets.chomp.downcase.to_sym
    promote_to(type)
  end
end
