# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/chess_board'
require_relative '../lib/messages'

# Module for Game Logic
module GameLogic
  def setting_up_ranks(player)
    army = player.army
    starting_rows = player.eql?(:white) ? [0, 1] : [7, 6]
    @board[starting_rows[0]] = army.sort_back_rank
    @board[starting_rows[1]] = army.sort_pawn_rank
  end
end
