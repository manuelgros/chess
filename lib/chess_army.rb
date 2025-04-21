# frozen_string_literal: true

require 'chess_army'

# Class for ChessArmy
class ChessArmy
  attr_reader :color, :full_army

  def initialize(color)
    @color = color
    @chess_piece_database = {
      pawn: [:pawn, 8, [[1, 0], [1, 1], [1, -1]], 1],
      rook: [:rook, 2, [[1, 0], [-1, 0], [0, 1], [0, -1]], 7],
      knights: [:knight, 2, [[2, 1], [2, -1], [1, 2], [1, -2]], 1],
      bishops: [:bishop, 2, [[1, 1], [1, -1], [-1, 1], [-1, -1]], 7],
      queen: [:queen, 1, [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]], 7],
      king: [:king, 1, [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]], 1]
    }
    @full_army = create_full_army(@color, chess_piece_database)
  end

  def create_chess_piece(array)
    ChessPiece.new(array)
  end

  def create_full_army(color, hash)
    hash.each_value_with_object([]) do |full_set, value|
      value[1].times do
        full_set << create_chess_piece(color, value)
      end
    end
  end
end
