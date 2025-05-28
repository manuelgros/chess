# forzen_string_literal: true

# King class
class King < ChessPiece
  # returns arrays with all coordinates that are in reach of enemy pieces
  # def danger_zone
  #   opponent.army.each_with_object([]) do |piece, danger_zone|
  #     danger_zone.concat(piece.valid_moves)
  #   end
  # end

  # def check?
  #   current_pos = position
  #   danger_zone.include?(current_pos)
  # end

  def check?
    opponent.army.each do |piece|
      return true if piece.valid_moves.include?(king.position)
    end

    false
  end

  def check_mate?
    check? && !any_moves
  end

  # def reach(direction)
  #   super(direction).reject { |coord| danger_zone.include?(coord) }
  # end

  # def valid_moves
  #   super.reject { |coord| danger_zone.include?(coord) }
  # end
end
