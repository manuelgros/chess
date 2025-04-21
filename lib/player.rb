# frozen_string_literal: true

require_relative '../lib/messages'

# Player Class
class Player
  include Messages
  attr_reader :name, :color, :number, :army

  def initialize(number, color)
    @name = ask_player_name
    @color = color
    @number = number
    @army = ChessArmy.new(color)
  end

  def ask_player_name
    print player_messages(get_name)
    gets.chomp
  end
end
