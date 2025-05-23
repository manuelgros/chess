# frozen_string_literal: true

# Class for single ChessPiece
class ChessPiece
  attr_reader :color, :type, :movement, :range, :board

  def initialize(color, type, movement, range, board)
    @color = color
    @type = type
    @movement = movement
    @range = range
    @board = board
  end

  def position
    @board.squares.each_with_index do |row, y_coord|
      x_coord = row.index(self)
      return [y_coord, x_coord] if x_coord
    end
    nil
  end

  # Takes coordinate array ([3, 5] = board[3][5]). It transfers ChessPiece object from current position to
  # destination
  def move(destination)
    current_position = position # method to find own position
    @board.squares[destination[0]][destination[1]] = @board.squares[current_position[0]][current_position[1]]
    @board.squares[current_position[0]][current_position[1]] = nil
  end

  # Not sure if needed yet
  def capture(other_piece)
    opponent = current_player == player_one ? player_two : player_one
    opponent.army.delete(other_piece)
  end

  # calculates new coordinate on @board from position and direction, used in reach()
  def next_square(position, direction)
    position.zip(direction).map { |coord, movement| coord + movement }
  end

  # takes coordinate array and validates format as well as inclusion in @board for reach()
  def valid_coordinate?(position)
    position.none?(&:negative?) && @board.includes_coordinates?(position)
  end

  # takes direction as array (exp. [1, 0] -> up) and calculates all reachable squares, based on position() and @range
  def reach(direction)
    reachable = []
    position = position()

    @range.times do
      position = next_square(position, direction)
      break unless valid_coordinate?(position)

      square = @board.select_square(position)

      if square.nil?
        reachable << position
      else
        reachable << position if square.color != @color
        break

      end
    end
    reachable
  end

  # Takes all directions arrays from @movement and calls range for each. Returns array with all valid coordinates
  def valid_moves
    @movement.each_with_object([]) do |direction, valid_moves|
      valid_moves.concat(reach(direction))
    end
  end

  def any_moves?
    return false if valid_moves.empty?

    true
  end
end

# Subclass Pawn
class Pawn < ChessPiece
  attr_accessor :moved_yet
  attr_reader :capture_moves

  def initialize(color, type, movement, range, board)
    super
    @movement = @color == :white ? movement[:white] : movement[:black]
    @moved_yet = false
    @capture_moves = @color.eql?(:white) ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
  end

  # checks if Pawn can attack and if so, returns array with additional valid directions, to be
  # added in valid_moves
  def attack_moves
    position = position()
    @capture_moves.each_with_object([]) do |direction, extra_moves|
      target = @board.select_square(next_square(position, direction))
      extra_moves << direction unless target.nil? || target.color == @color
    end
  end

  def reach(direction)
    @range = @moved_yet ? 1 : 2
    super(direction)
  end

  def valid_moves
    # current_position = position
    moves = @movement.concat(attack_moves)
    moves.each_with_object([]) do |direction, valid_moves|
      valid_moves.concat(reach(direction))
    end
  end

  def move(destination)
    super(destination)
    @moved_yet = true if @moved_yet == false
  end
end
