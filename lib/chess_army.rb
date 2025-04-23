# frozen_string_literal: true

require_relative '../lib/chess_piece'
require_relative '../lib/chess_piece_database'

# Class for ChessArmy
class ChessArmy
  attr_reader :color, :full_set, :piece_database

  include ChessPieceDatabase

  def initialize(color)
    @color = color
    @full_set = create_full_set(@color, chess_piece_database)
  end

  # Takes parameter to create ChessPiece object
  def create_chess_piece(color, typ, attributes)
    ChessPiece.new(color, typ, attributes)
  end

  # Uses database hash to built chess pieces in appropriate amount and returns full_set array
  def create_full_set(color, piece_database)
    full_set = []
    piece_database.each_pair do |type, attributes|
      attributes[:amount].times do
        full_set << create_chess_piece(color, type, attributes)
      end
    end
    full_set
  end

  # Returns array with ChessPiece object in correct order for setup on board; setup_order from ChessPieceDatabase module
  # starting with major rank array[0..7] and pawn rank array[8..15]
  def sort_ranks_for_start
    expected_order = setup_order
    expected_order.map do |type|
      @full_set.delete_at(full_set_arr.find_index { |chess_piece| chess_piece.type == type })
    end
  end
end
