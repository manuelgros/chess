# frozen_string_literal: true

require_relative '../lib/player'

# Message module
module Messages
  def player_messages(message)
    {
      get_name: 'Type in name for Player: '
    }[message]
  end

  def game_messages(message)
    {}[message]
  end
end
