# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/game'

# Message module
module Messages
  # Methods for getting and validating player inputs

  def valid_digits?(string)
    string.match?(/\A[0-7]+\z/)
  end

  def validate_coordinate_input(input_arr)
    input_arr.size == 2 && input_arr.all?(&method(:valid_digits?))
  end

  def ask_coordinates
    selection = gets.chomp.chars
    return selection.map(&:to_i) if validate_coordinate_input(selection)

    puts player_messages(:coord_input_error)
    ask_coordinates
  end

  # Methods to output various messages for the game

  # rubocop:disable Layout/LineLength
  def player_messages(message)
    {
      get_name: "Type in name for #{@color} Player: ",
      get_selection: "#{@name} select chess piece by coordinates: ",
      get_destination: 'Select target for move by: ',
      coord_input_error: 'Invalid input. Please type coordinates on the X and Y axis between 0 and 7 (example: 24)',
      invalid_destination: 'The target you selected is invalid. Please select a different square on the board',
      invalid_selection: "This selection is invalid or there are no moves available for this piece. Please select a different piece for your move.\n\n"
    }[message]
  end

  def game_messages(message)
    {
      capture: "#{piece.color} #{piece.type} captures #{destination.color} #{destination.type}",
      move: "#{active_piece.color} #{active_piece.type} moves to #{target[0]} #{target[1]}",
      invalid_move: "Invalid move for #{active_piece.color} #{active_piece.type}. Please select something else."
    }[message]
  end
  # rubocop:enable Layout/LineLength
end
