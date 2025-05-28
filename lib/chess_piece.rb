# frozen_string_literal: true

# Class for single ChessPiece
class ChessPiece
  attr_reader :color, :type, :movement, :range, :board

  def initialize(color, board, type, database)
    @color = color
    @board = board
    @type = type
    @movement = database[:move_direction]
    @range = database[:range]
  end

  # METHODS TO DETERMINE VARIOUS STATES OF PIECEs - BEGIN
  def position
    board.squares.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  def opponent_color
    color == :white ? :black : :white
  end

  def opponent_army
    board.squares.select do |piece|
      piece.color == opponent_color
    end
  end

  def commander
    board.side[color]
  end

  def enemy?(target)
    target.color == opponent_color
  end

  def any_moves?
    return false if valid_moves.empty?

    true
  end

  # Needed?
  def friend?(field)
    field.color == @color
  end
  # METHODS TO DETERMINE VARIOUS STATES OF PIECEs - END

  def move(destination)
    start = position
    board.change_square(destination, self)
    board.change_square(start, EmptySquare.new)
    destination
  end

  # takes direction (exp. [1, 0] -> up) and returns all reachable squares, based on position() and @range
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
        reachable << current_pos if enemy?(target)
        break
      end
    end
    reachable
  end

  # returns array with all reachable squares in all possible directions
  def valid_moves
    movement.each_with_object([]) do |direction, valid_moves|
      valid_moves.concat(reach(direction))
    end
  end

  # check if moving the piece would cause Player to be in check
  def cause_check?
    current_position = position
    board.change_square(current_position, EmptySquare.new)
    result = commander.check?
    board.change_square(current_position, self)
    result
  end
  # METHOD TO DETERMINE VALID MOVEMENTS DURING TURN - END
end

# Subclass Pawn
class Pawn < ChessPiece
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

  # returns array with coordinated if target is enemy
  def attack_moves(direction)
    direction.select do |attack_direction|
      target_coord = board.next_square(position, attack_direction)
      next unless board.includes_coordinates?(target_coord)

      target = @board.select_square(target_coord)
      enemy?(target)
    end
  end

# King class
class King
  # returns arrays with all coordinates that are in reach of enemy pieces
  def danger_zone
    opponent_army.each_with_object([]) do |piece, danger_zone|
      danger_zone.concat(piece.valid_moves)
    end
  end

  # Option A
  def reach(direction)
    position = position()

    (1..@range).each_with_object([]) do |_, reachable|
      position = next_square(position, direction)
      break unless valid_coord?(position)

      target = @board.select_square(position)

      next reachable << position if target.type == :empty && !danger_zone.include?(target)

      reachable << position if target.enemy?
      break
    end
  end

  # adjusted reach(), deletes all coordinates that outs king into check
  # Option B
  def x_reach
    super
    danger_zone.each do |coord|
      reachable.delete(coord)
    end
    reachable
  end
end
