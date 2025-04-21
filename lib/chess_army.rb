# frozen_string_literal: true

require 'chess_army'

# Class for ChessArmy
class ChessArmy
  attr_reader :color, :full_army, :piece_database

  def initialize(color)
    @color = color
    @piece_database = [
      [:pawn, 8, [[1, 0], [1, 1], [1, -1]], 1],
      [:rook, 2, [[1, 0], [-1, 0], [0, 1], [0, -1]], 7],
      [:knight, 2, [[2, 1], [2, -1], [1, 2], [1, -2]], 1],
      [:bishop, 2, [[1, 1], [1, -1], [-1, 1], [-1, -1]], 7],
      [:queen, 1, [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]], 7],
      [:king, 1, [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]], 1]
    ]
    @full_army = create_full_army(@color, piece_database)
  end

  def create_chess_piece(color, array)
    ChessPiece.new(color, array)
  end

  def create_full_army(color, database)
    database.each_with_object({}) do |piece, army|
      army[piece[0]] = Array.new(piece[1]) { create_chess_piece(color, piece) }
      # for i in 1..piece[1]
      #   army[piece[0]][i] = create_chess_piece(color, piece)
      # end
    end
  end
end
