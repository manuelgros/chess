# frozen_string_literal: true

require_relative '../lib/army'
require_relative '../lib/game'

# Message module
module GameCommunication
  # INPUT METHODS
  def valid_digits?(string)
    string.match?(/\A[0-7]+\z/)
  end

  def validate_coordinate_input?(input_arr)
    input_arr.size == 2 && input_arr.all?(&method(:valid_digits?))
  end

  def ask_coordinates
    selection = gets.chomp.chars
    return selection.map(&:to_i) if validate_coordinate_input?(selection)

    puts player_messages(:coord_input_error)
    ask_coordinates
  end

  # OUTPUT METHODS
  # rubocop:disable Layout/LineLength, Metrics/AbcSize
  def player_messages(message)
    {
      get_name: "Type in name for #{color} Player: ",
      get_selection: "#{player_name} select chess piece by coordinates: ",
      get_destination: 'Select target for move by: ',
      coord_input_error: 'Invalid input. Please type coordinates on the X and Y axis between 0 and 7 (example: 24)',
      invalid_destination: 'The target you selected is invalid. Please select a different square on the board',
      invalid_selection: "This selection is invalid or there are no moves available for this piece. Please select a different piece for your move.\n\n"
    }[message]
  end

  def piece_messages(message, piece)
    {
      piece_moves: "Selected piece: #{(piece.color.to_s.capitalize + piece.type.to_s.capitalize).green}\nMoves: #{piece.save_moves.to_s.green}",
      move: "#{(piece.color.to_s.capitalize + piece.type.to_s.capitalize).green} moves to #{piece.position[0].to_s.green} | #{piece.position[1].to_s.green}",
      invalid_move: "Invalid move for #{(piece.color.to_s.capitalize + piece.type.to_s.capitalize).green}. Please select something else."
    }[message]
  end

  def game_messages(message)
    {
      new_turn: "#{@current_player.player_name}, it is your turn.\n\n"
    }[message]
  end

  def capture_messages(message, piece, target)
    {
      capture: "#{piece.color.capitalize} #{piece.type.capitalize} captures #{@board.select_square(target).color.capitalize} #{@board.select_square(target).type.capitalize} on #{target[0]} / #{target[1]}"
    }[message]
  end
  # rubocop:enable Layout/LineLength, Metrics/AbcSize
end
