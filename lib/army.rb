# frozen_string_literal: true

require_relative '../lib/game_communication'
require_relative '../lib/chess_piece'
require_relative '../lib/chess_piece_database'
require_relative '../lib/pawn'
require_relative '../lib/en_passant'

# Player Class
class Army
  include GameCommunication
  include ChessPieceDatabase
  include EnPassant

  attr_reader :player_name, :color, :board, :army

  def initialize(color, board)
    @color = color
    @player_name = ask_player_name
    @board = board
    @army = create_army
  end

  def ask_player_name
    print player_messages(:get_name)
    gets.chomp.capitalize
  end

  def opponent_color
    color == :white ? :black : :white
  end

  # returns array with all enemy pieces on board
  def opponent_army
    board.squares.flatten.select { |piece| piece.color == opponent_color }
  end

  def opponent
    board.side[opponent_color]
  end

  def king
    board.squares.flatten.find { |piece| piece.color == color && piece.type == :king }
  end

  def check?
    opponent_army.each do |piece|
      return true if piece.valid_moves.include?(king.position)
    end

    false
  end

  def check_mate?
    check? && !king.any_moves?
  end

  def select_piece
    puts player_messages(:get_selection)
    selected_piece = @board.select_square(ask_coordinates)
    if selected_piece.any_moves? && selected_piece.color == @color
      selected_piece
    else
      puts player_messages(:invalid_selection)
      select_piece
    end
  end

  def select_destination
    puts player_messages(:get_destination)
    destination = ask_coordinates
    target = @board.select_square(destination)
    return destination unless target.color == @color

    puts player_messages(:invalid_destination)
    select_destination
  end

  # Methods to create and sort chess army
  def create_chess_piece(type)
    database = chess_piece_database[type]
    if type == :pawn
      Pawn.new(@color, @board, type, database)
    else
      ChessPiece.new(@color, @board, type, database)
    end
  end

  def create_army
    army_database.each_with_object([]) do |piece_type, full_set|
      # database = chess_piece_database[piece_type]
      full_set << create_chess_piece(piece_type)
    end
  end
end
