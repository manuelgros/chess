# frozen_string_literal: true

require_relative '../lib/army'
require_relative '../lib/game'

# Message module
module GameCommunication
  # OUTPUT METHODS
  # rubocop:disable Layout/LineLength, Metrics/AbcSize
  def player_messages(message)
    {
      # get_name: "Type in name for #{color} Player: ",
      get_selection: "#{current_player.player_name} type in command or select chess piece by coordinates: ",
      get_destination: "Select destination by coordinated or #{'back'.blue} to select different piece: ",
      coord_input_error: 'Invalid input. Please select a valid command or a valid board coordinate (example: 14)',
      invalid_destination: 'The target you selected is invalid. Please select a different square on the board',
      invalid_selection: "This selection is invalid or there are no moves available for this piece. Please select a different piece for your move.\n\n"
    }[message]
  end

  def piece_messages(message, piece)
    {
      piece_moves: "Selected piece: #{(piece.color.to_s.capitalize + piece.type.to_s.capitalize).green}\nMoves: #{piece.save_moves.to_s.green}",
      move: "#{(piece.color.to_s.capitalize + piece.type.to_s.capitalize).green} moves to #{piece.position[0].to_s.green} | #{piece.position[1].to_s.green}\n",
      invalid_move: "Invalid move for #{(piece.color.to_s.capitalize + piece.type.to_s.capitalize).green}. Please select something else."
    }[message]
  end

  def game_messages(message)
    {
      new_turn: "\n#{@current_player.player_name}, it is your turn.".yellow.bold
    }[message]
  end

  def capture_messages(message, piece, target)
    {
      capture: "#{piece.color.capitalize} #{piece.type.capitalize} captures #{@board.select_square(target).color.capitalize} #{@board.select_square(target).type.capitalize} on #{target[0]} / #{target[1]}"
    }[message]
  end
  # rubocop:enable Layout/LineLength, Metrics/AbcSize
end
