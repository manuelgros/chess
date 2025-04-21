# frozen_string_literal: true

require 'chess_piece'

# Class for ChessArmy
class ChessArmy
  attr_reader :color, :full_set, :piece_database

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
    @full_set = create_full_set(@color, piece_database)
  end

  def create_chess_piece(color, array)
    ChessPiece.new(color, array)
  end

  def create_full_full_set(color, database)
    database.each_with_object({}) do |piece, full_set|
      full_set[piece[0]] = Array.new(piece[1]) { create_chess_piece(color, piece) }
    end
  end

  def sort_pawn_rank
    @full_set[:pawn]
  end

  def sort_back_rank
    [
      full_set[:rook][0], full_set[:knight][0],
      full_set[:bishop][0], full_set[:king][0],
      full_set[:queen][0], full_set[:bishop][1],
      full_set[:knight][1], full_set[:rook][1]
    ]
  end
end
