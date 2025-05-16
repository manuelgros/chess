# frozen_String_literal: true

require_relative '../lib/chess_piece'
require_relative '../lib/chess_board'

describe ChessPiece do
  movement = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  range = 7
  let(:board) { ChessBoard.new }
  subject(:rook) { described_class.new(:white, :rook, movement, range, board) }
  before do
    board.squares[0][0] = rook
  end

  describe '#move' do
    context 'when calling #move on the chess piece' do
      it 'will be stored at the new location in board' do
        new_location = [1, 0]
        rook.move(new_location)
        expect(board.select_square(new_location)).to eq(rook)
      end
    end
  end
end
