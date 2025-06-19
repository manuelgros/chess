# frozen_string_literal: true

require 'yaml'
require './lib/game_communication'
# Module that allows the game to be saved
module Saveable
  include GameCommunication

  def self.included(base)
    base.extend(ClassMethods)
    base.extend(Messages)
  end

  # INSTANCE METHODS TO SAVE GAME - BEGIN
  # ---------------------------------------------------
  def save_game
    Game.display_slots
    print Game.saveable_messages(:select_save)
    selection = gets.chomp

    return write_save(self, selection) if selection.match?(/\A[1-3]{1}\z/)

    puts Game.saveable_messages(invalid_selection)
    save_game
  end

  def write_save(game, number)
    filename = Game.save_slots_arr[number.to_i]
    File.open(filename, 'w') do |file|
      file.puts game.to_yaml
    end
  end
  # ---------------------------------------------------
  # INSTANCE METHODS TO SAVE GAME - END

  # NESTED MODULE - CLASS METHODS TO LOAD GAMES
  module ClassMethods
    def select_game
      return Game.new.full_match if saves_available?

      puts saveable_messages(:want_to_load)
      if gets.chomp == '1'
        select_save
      else
        Game.new.full_match
      end
    end

    def saves_available?
      save_slots_arr[1..].all? { |file| File.empty?(file) }
    end

    def save_slots_arr
      slot1 = File.open('./save_games/save_slot_1.yaml', 'r')
      slot2 = File.open('./save_games/save_slot_2.yaml', 'r')
      slot3 = File.open('./save_games/save_slot_3.yaml', 'r')
      ['', slot1, slot2, slot3]
    end

    def select_save
      display_slots
      print saveable_messages(:select_save)
      selection = gets.chomp
      if selection.match?(/\A[1-3]{1}\z/) && !File.empty?(save_slots_arr[selection.to_i])
        return load_game(selection.to_i)
      elsif selection.downcase == 'new'
        Game.new.full_match
      end

      puts saveable_messages(:invalid_load)
      select_save
    end

    def load_game(number)
      game = YAML.unsafe_load(Game.save_slots_arr[number])
      game.full_match
    end

    def display_file(file)
      return '---empty---' if File.empty?(file)

      game = YAML.unsafe_load(file)
      "#{game.white_army.player_name} || #{game.black_army.player_name}"
    end

    def display_slots
      Game.save_slots_arr.each_with_index do |file, idx|
        next if idx.zero?

        puts "[#{idx}]".green + " Slot: #{display_file(file)}"
      end
    end
  end

  # nested Module to save Messages for Save/Load function
  module Messages
    def saveable_messages(message)
      {
        want_to_load: "Do you want to load an existing game or start new?\n#{'[1]'.green} LOAD\n#{'[2]'.green} NEW ",
        select_save: 'Select slot by number or type NEW to start new game:',
        invalid_selection: 'Invalid selection. Select one of the three slots by number (1 2 3)',
        invalid_load: "Invalid selection OR empty save game, choose again...\n".yellow
      }[message]
    end
  end
end
