# frozen_string_literal: true

# PieceDatabase Module; stores information to create the various chess pieces
module ChessPieceDatabase
  # Returns hash storing attributes for each Chess Piece; calling patter: pice_database[:piece_typ][:attribute]
  def chess_piece_database # rubocop:disable Metrics/MethodLength
    {
      pawn: {
        typ: :pawn,
        amount: 8,
        moves: [[1, 0], [1, 1], [1, -1]],
        range: 1
      },
      rook: {
        typ: :pawn,
        amount: 2,
        moves: [[1, 0], [-1, 0], [0, 1], [0, -1]],
        range: 7
      },
      knight: {
        typ: :pawn,
        amount: 2,
        moves: [[2, 1], [2, -1], [1, 2], [1, -2]],
        range: 1
      },
      bishop: {
        typ: :pawn,
        amount: 2,
        moves: [[1, 1], [1, -1], [-1, 1], [-1, -1]],
        range: 7
      },
      queen: {
        typ: :pawn,
        amount: 1,
        moves: [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]],
        range: 7
      },
      king: {
        typ: :pawn,
        amount: 1,
        moves: [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]],
        range: 1
      }
    }
  end

  def pawn_rank_order
    Array.new(8, :pawn)
  end

  def major_rank_order
    %i[rook knight bishop queen king bishop knight rook]
  end

  def setup_order
    major_rank_order + pawn_rank_order
  end
end
