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
  def reach(direction) # rubocop:disable Metrics/MethodLength
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
  def initialize(color, board, type, database)
    super
    @movement = database[:moves][@color][:regular]
    @capture_moves = database[:moves][@color][:capture_moves]
    @first_move = true
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
