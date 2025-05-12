# frozen_string_literal: true

require_relative '../lib/chess_board'

describe ChessBoard do
  subject(:board) { described_class.new }

  describe '#initialize' do
    context 'when ChessBoard is initialized' do
      let(:array) { board.squares }

      it 'creates nested array with top-level size of 8' do
        first_level = array.size
        expect(first_level).to eq(8)
      end

      it 'each second-level array has a size of 8' do
        array.each_with_index do |second_level, index|
          expect(second_level.size).to eq(8), "Expected row #{index} to have 8 columns"
        end
      end
    end
  end

  describe '#includes_coordinates?' do
    context 'when checking for a coordinate that is included in the board array' do
      let(:valid_coord) { [3, 5] }

      it 'returns true' do
        answer = board.includes_coordinates?(valid_coord)
        expect(answer).to eq(true)
      end
    end

    context 'when checking for a coordinate outside the board array' do
      context 'with positive coordinates' do
        let(:invalid_coord) { [9, 5] }

        it 'returns false' do
          answer = board.includes_coordinates?(invalid_coord)
          expect(answer).to eq(false)
        end
      end

      context 'with negative coordinates' do
        let(:invalid_coord) { [-6, 4] }

        it 'returns false' do
          answer = board.includes_coordinates?(invalid_coord)
          expect(answer).to eq(false)
        end
      end
    end
  end
end
