# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/chess_board'
require_relative '../lib/messages'

# Module for Game Logic
module GameLogic
  
  def move_piece(select_arr, dest_arr)
    @board[dest_arr[0]][dest_arr[1]] = @board[select_arr[0]][select_arr[1]]
    @board[select_arr[0]][select_arr[1]] = nil
  end
  
end
