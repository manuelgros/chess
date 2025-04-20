# frozen_string_literal: true

require 'messages'

# Player Class
class Player
  def initialize(number, color)
    @name = ask_player_name
    @color = color
    @number = number
  end

  def ask_player_name
    print player_messages(get_name)
    gets.chomp
  end
end
