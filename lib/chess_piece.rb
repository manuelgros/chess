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

  def opponent
    board.side[opponent_color]
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
  # def cause_check?
  #   current_position = position
  #   board.change_square(current_position, EmptySquare.new)
  #   result = commander.check?
  #   board.change_square(current_position, self)
  #   result
  # end

  def king
    commander.army.find { |piece| piece.type == :king }
  end

  def cause_check?(coord)
    start = position
    target = board.select_square(coord)
    move(coord)
    result = king.check?
    move(start)
    board.change_square(coord, target)
    result
  end
  # METHOD TO DETERMINE VALID MOVEMENTS DURING TURN - END
end

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

# King class
class King < ChessPiece
  # returns arrays with all coordinates that are in reach of enemy pieces
  # def danger_zone
  #   opponent.army.each_with_object([]) do |piece, danger_zone|
  #     danger_zone.concat(piece.valid_moves)
  #   end
  # end

  # def check?
  #   current_pos = position
  #   danger_zone.include?(current_pos)
  # end

  def check?
    opponent.army.each do |piece|
      return true if piece.valid_moves.include?(king.position)
    end

    false
  end

  def check_mate?
    check? && !any_moves
  end

  # def reach(direction)
  #   super(direction).reject { |coord| danger_zone.include?(coord) }
  # end

  # def valid_moves
  #   super.reject { |coord| danger_zone.include?(coord) }
  # end
end
