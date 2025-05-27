# frozen_string_literal: true

# Class for single ChessPiece
class ChessPiece
  attr_reader :color, :type, :movement, :range, :board

  def initialize(color, board, type, database)
    @color = color
    @board = board
    @type = type
    @movement = database[:moves]
    @range = database[:range]
  end

  # METHODS TO DETERMINE VARIOUS STATES OF PIECEs - BEGIN
  def position
    @board.squares.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  def opponent_color
    @color == :white ? :black : :white
  end

  def enemy?
    # field.color != @color && field.color != :none
    @color == opponent_color
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
    @board.change_square(destination, self)
    @board.change_square(start, EmptySquare.new)
  end

  # METHOD TO DETERMINE VALID MOVEMENTS DURING TURN - BEGIN
  # returns next square in given direction from position
  def next_square(position, direction)
    position.zip(direction).map { |coord, movement| coord + movement }
  end

  # returns given coordinated if they are valid
  def valid_coord?(coord)
    coord.none?(&:negative?) && @board.includes_coordinates?(coord)
  end

  # takes direction (exp. [1, 0] -> up) and returns all reachable squares, based on position() and @range
  def reach(direction) # rubocop:disable Metrics/MethodLength
    reachable = []
    position = position()

    @range.times do
      position = next_square(position, direction)
      break unless valid_coord?(position)

      target = @board.select_square(position)

      if target.type == :empty
        reachable << position
      else
        reachable << position if target.enemy?
        break

      end
    end
    reachable
  end

  # returns array with all reachable squares in all possible directions
  def valid_moves
    @movement.each_with_object([]) do |direction, valid_moves|
      valid_moves.concat(reach(direction))
    end
  end
  # METHOD TO DETERMINE VALID MOVEMENTS DURING TURN - END
end

# Subclass Pawn
class Pawn < ChessPiece
  def initialize(color, board, type, database)
    super
    @movement = database[:moves][@color][:regular]
    @capture_moves = database[:moves][@color][:capture_moves]
    @first_move = true
  end

  # returns additional directions IF field is occupied by opponent piece
  def attack_moves
    @capture_moves.select do |attack_direction|
      target_coord = next_square(position, attack_direction)
      next unless valid_coord?(target_coord)

      target = @board.select_square(target_coord)
      target.enemy?
    end
  end

  def reach(direction)
    @range = @first_move ? 2 : 1 # change to use range data from database
    super(direction)
  end

  def valid_moves
    moves = @movement.concat(attack_moves)
    moves.each_with_object([]) do |direction, valid_moves|
      valid_moves.concat(reach(direction))
    end
  end

  def move(destination)
    super(destination)
    @first_move = false if @first_move
  end
end
