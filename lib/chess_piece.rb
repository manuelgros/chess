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

  # METHODS TO DETERMINE VARIOUS INFORMATION ABOUT BOTH SIDES AND SELF - BEGIN
  # ---------------------------------------------------------------------------
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

  def king
    commander.army.find { |piece| piece.type == :king }
  end

  def enemy?(target)
    target.color == opponent_color
  end

  def any_moves?
    # return false if valid_moves.empty?
    return false if save_moves.empty?

    true
  end

  # Needed?
  def friend?(field)
    field.color == @color
  end
  # ---------------------------------------------------------------------------
  # METHODS TO DETERMINE VARIOUS INFORMATION ABOUT BOTH SIDES AND SELF - END

  # METHODS FOR FINDING VALID MOVES - BEGIN
  # ------------------------------------------------------
  def move(destination)
    start = position
    board.change_square(destination, self)
    board.change_square(start, EmptySquare.new(board))
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
  # -----------------------------------------------------
  # METHODS FOR FINDING VALID MOVES - END

  # METHODS TO DEAL WITH CHECK? - NOT FUNCTIONAL YET - BEGIN
  # --------------------------------------------------------
  def save_moves
    moves = valid_moves
    moves.reject { |coord| cause_check?(coord) }
  end

  # ERROR: somewhere during execution, position gives back nil which causes crash
  # possible that pice is calling method while not on the field
  def cause_check?(coord)
    start = position
    target = board.select_square(coord)
    move(coord)
    result = commander.check?
    rewind_move(target, start)
    result
  end

  def rewind_move(target, start)
    current_pos = position
    move(start)
    board.change_square(current_pos, target)
  end
end
# --------------------------------------------------------
# METHODS TO DEAL WITH CHECK? - NO FUNCTIONAL YET - END
