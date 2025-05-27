# frozen_string_literal: true

# PieceDatabase Module; stores information to create the various chess pieces
module ChessPieceDatabase
  # Returns hash storing attributes for each Chess Piece; calling patter: pice_database[:piece_typ][:attribute]
  # :move_direction is array with the direction the pieces can travel ([1, 0] => one up)
  # :range decides how far a piece can go (7 = can potentially cross the entire board)
  def chess_piece_database # rubocop:disable Metrics/MethodLength
    {
      pawn: {
        amount: 8,
        move_direction: {
          white: {
            move: [[1, 0]],
            capture: [[1, 1], [1, -1]]
          },
          black: {
            move: [[-1, 0]],
            capture: [[-1, 1], [-1, -1]]
          }
        },
        start_range: 2,
        range: {
          regular: 1,
          start: 2
        }
      },
      rook: {
        amount: 2,
        move_direction: [[1, 0], [-1, 0], [0, 1], [0, -1]],
        range: 7
      },
      knight: {
        amount: 2,
        move_direction: [[2, 1], [-2, -1], [1, 2], [-1, -2], [1, -2], [2, -1], [-1, 2], [-2, 1]],
        range: 1
      },
      bishop: {
        amount: 2,
        move_direction: [[1, 1], [1, -1], [-1, 1], [-1, -1]],
        range: 7
      },
      queen: {
        amount: 1,
        move_direction: [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]],
        range: 7
      },
      king: {
        amount: 1,
        move_direction: [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]],
        range: 1
      }
    }
  end

  def army_database
    %i[rook knight bishop queen king bishop knight rook pawn pawn pawn pawn pawn pawn pawn pawn]
  end
end
