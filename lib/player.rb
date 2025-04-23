# frozen_string_literal: true

require_relative '../lib/messages'
require_relative '../lib/chess_army'

# Player Class
class Player
  include Messages
  attr_reader :name, :color, :army

  def initialize(color)
    @color = color
    @name = ask_player_name
    @army = ChessArmy.new(color)
  end

  def ask_player_name
    print player_messages(:get_name)
    gets.chomp
  end
end
