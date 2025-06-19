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
    select_game # Method from Saveable Module
  end

  def change_current_player
    @current_player = current_player == white_army ? black_army : white_army
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

  def destination_input
    puts player_messages(:get_destination)
    input = gets.downcase.strip

    if input == 'back'
      send(COMMAND_MAP[input])
    elsif input.match?(/\A[0-7]{2}\z/)
      input.chars.map(&:to_i)
    else
      puts player_messages(:coord_input_error)
      destination_input
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
      puts game_messages(:new_turn)
      take_turn
      break if check_mate?

      change_current_player
    end
    puts "#{current_player.player_name} won!"
  end

  def check_mate?
    current_player.opponent.check_mate?
  end

  # basic methods, may need extension
  def capitulate
    winner = current_player.opponent.player_name
    puts "#{current_player.player_name} has given up. #{winner} has won!"
    exit
  end

  # Add reminder to save when feature is available
  def exit_game
    puts 'Game is terminated'
    exit
  end
  # ---------------------------------------------------------
  # METHODS FOR GENERAL GAME LOGIC - END

  # METHODS TO MAKE A MOVE - BEGIN
  # ------------------------------------------------------------
  def move_piece(selection)
    active_piece = validate_piece_selection(selection)
    target = select_destination(active_piece)
    active_piece.move(target)
    puts piece_messages(:move, active_piece)
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
    player_input
  end

  def select_destination(active_piece)
    destination = destination_input
    return destination if active_piece.save_moves.include?(destination)

    puts piece_messages(:invalid_move, active_piece)
    select_destination(active_piece)
  end

  def valid_piece?(piece)
    piece.any_moves? && current_player.owns?(piece)
  end
  # ------------------------------------------------------------
  # METHODS TO MAKE A MOVE - END
end
