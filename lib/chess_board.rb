# frozen_string_literal: true

# Chess_board class
class ChessBoard
  def initialize
    @coordinates = create_board_coordinates
  end

  def create_board_coordinates
    Array.new(7) { Array 0..8 }
  end

  def create_chess_board
    base_arr = Array 0..7
    base_arr.each_with_object([]) do |first_ele, coordinates_arr|
      base_arr.each { |second_arr| coordinates_arr << [first_ele, second_arr] }
    end
  end
end
