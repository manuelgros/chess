# frozen_string_literal: true

require_relative '../lib/army'
require_relative '../lib/chess_board'
require_relative '../lib/empty_square'
require_relative '../lib/game_communication'
require_relative '../lib/rendering'
require './lib/saveable'

# Class for Game Logic
class Game
  include GameCommunication
  include Rendering
  include Saveable

  attr_reader :board, :white_army, :black_army
  attr_accessor :current_player

  COMMAND_MAP = {
    'back' => :take_turn,
    'capitulate' => :capitulate,
    'exit' => :exit_game,
    'save' => :save_game
  }.freeze

  def initialize
    @board = ChessBoard.new
    @white_army = board.side[:white]
    @black_army = board.side[:black]
    @current_player = @white_army
  end

  def self.start_game
    puts introduction
    select_game # Method from Saveable Module
  end

  # INPUT METHODS - BENIN
  # ---------------------------------------------------------
  def player_input
    puts player_messages(:get_selection)
    input = gets.downcase.strip

    if COMMAND_MAP.key?(input)
      send(COMMAND_MAP[input])
    elsif input.match?(/\A[0-7]{2}\z/)
      move_piece(input.chars.map(&:to_i))
    else
      puts player_messages(:coord_input_error)
      player_input
    end
  end
  # ---------------------------------------------------------
  # INPUT METHODS END

  # METHODS FOR GENERAL GAME LOGIC - BEGIN
  # ---------------------------------------------------------
  def take_turn
    display_board
    current_player.reset_en_passant
    player_input
  end

  def full_match
    # script to run a full match until end conditions are met (win, draw, capitulation etc.)
    loop do
      puts player_messages(:new_turn)
      take_turn
      break if check_mate?
    end
    puts "#{current_player.player_name} won!"
    play_again
  end

  def check_mate?
    current_player.opponent.check_mate?
  end

  def change_current_player
    @current_player = current_player == white_army ? black_army : white_army
  end

  # basic methods, may need extension
  def capitulate
    puts player_messages(:capitulate)
    play_again
  end

  def play_again
    puts 'Do you want to play again?'
    answer = gets.chomp
    return Game.start_game if answer.downcase == 'y'

    exit
  end

  def exit_game
    puts 'You are about to exit the game. Do you want to serve first? (Y for yes / enter to skip)'
    answer = gets.chomp
    save_game if answer.downcase == 'y'
    exit
  end
  # ---------------------------------------------------------
  # METHODS FOR GENERAL GAME LOGIC - END

  # METHODS TO MAKE A MOVE - BEGIN
  # ------------------------------------------------------------
  def move_piece(selection)
    active_piece = validate_piece_selection(selection)
    return player_input if active_piece.nil?

    target = select_destination(active_piece)
    return send(COMMAND_MAP[target]) if target == 'back'

    puts piece_messages(:move, active_piece)
    active_piece.move(target)
    change_current_player
    nil
  end

  def validate_piece_selection(selection_arr)
    selected_piece = @board.select_square(selection_arr)

    if valid_piece?(selected_piece)
      display_board(selected_piece.save_moves)
      puts piece_messages(:piece_moves, selected_piece)
      return selected_piece
    end

    puts player_messages(:invalid_selection)
    nil
  end

  def valid_piece?(piece)
    piece.any_moves? && current_player.owns?(piece)
  end

  def select_destination(active_piece)
    puts player_messages(:get_destination)
    input = gets.downcase.strip

    return input if input == 'back'

    if input.match?(/\A[0-7]{2}\z/) && active_piece.save_moves.include?(input.chars.map(&:to_i))
      return input.chars.map(&:to_i)
    end

    puts piece_messages(:invalid_move, active_piece)
    select_destination(active_piece)
  end
  # ------------------------------------------------------------
  # METHODS TO MAKE A MOVE - END
end
