# frozen_string_literal: true

require_relative '../lib/player'

# Message module
module Messages
  def validate_coordinate_input(input_arr)
    @board.includes_coordinates?(input_arr) && input_arr.all?(&Integer.method(:===))
  end

  def player_messages(message)
    {
      get_name: "Type in name for #{@color} Player: ",
      get_selection: 'Select piece by coordinated: ',
      get_destination: 'Select filed to move the piece to: ',
      coord_input_error: 'Invalid input. Please type coordinates on the X and Y axis between 0 and 7 (example: 24)'
    }[message]
  end

  def game_messages(message)
    {
      capture: "#{piece.color} #{piece.type} captures #{destination.color} #{destination.type}"
    }[message]
  end
end
