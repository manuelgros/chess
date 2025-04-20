# frozen_string_literal: true

# Message module
module Messages
  def player_messages(message)
    {
      get_name: "Type in name for Player#{@number}: "
    }[message]
  end

  def game_messages(message)
    {}[message]
  end
end
