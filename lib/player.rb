# frozen_string_literal: true

require_relative '../lib/game_communication'
require_relative '../lib/chess_piece'
require_relative '../lib/chess_piece_database'

# Player Class
class Player
  include GameCommunication
  include ChessPieceDatabase

  attr_reader :name, :color, :army

  def initialize(color, board)
    @color = color
    @name = ask_name
    @board = board
    @army = create_full_set
  end

  def ask_name
    print player_messages(:get_name)
    gets.chomp.capitalize
  end

  def select_piece
    puts player_messages(:get_selection)
    selected_piece = @board.select_square(ask_coordinates)
    if selected_piece.nil? || !selected_piece.any_moves? || selected_piece.color != @color
      puts player_messages(:invalid_selection)
      select_piece
    else
      puts "Selected piece: #{selected_piece.color} #{selected_piece.type}" # PLACEHOLDER
      selected_piece
    end
  end

  def select_destination
    puts player_messages(:get_destination)
    destination = ask_coordinates
    target = @board.select_square(destination)
    return destination if target.nil? || target.color != @color

    puts player_messages(:invalid_destination)
    select_destination
  end

  # Methods to create and sort chess army
  def create_chess_piece(type, database)
    if type == :pawn
      Pawn.new(@color, @board, type, database)
    else
      ChessPiece.new(@color, @board, type, database)
    end
  end

  def create_full_set
    full_set = []
    chess_piece_database.each_pair do |type, database|
      database[:amount].times do
        full_set << create_chess_piece(type, database)
      end
    end
    full_set
  end

  def sort_ranks_for_start
    expected_order = setup_order
    expected_order.map do |type|
      @army.delete_at(@army.find_index { |chess_piece| chess_piece.type == type })
    end
  end
end
