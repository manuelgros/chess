# frozen_string_literal: true

require 'colorize'

# Module to render the chess game for display in console
module Rendering
  MARKER = {
    rook: ' R ',
    knight: ' N ',
    bishop: ' B ',
    queen: ' Q ',
    king: ' K ',
    pawn: ' P '
  }.freeze

  BLACK_SIDE = {
    king: " \u2654 ",
    queen: " \u2655 ",
    rook: " \u2656 ",
    bishop: " \u2657 ",
    knight: " \u2658 ",
    pawn: " \u2659 "
  }.freeze

  WHITE_SIDE = {
    king: " \u265a ",
    queen: " \u265b ",
    rook: " \u265c ",
    bishop: " \u265d ",
    knight: " \u265e ",
    pawn: " \u265f "
  }.freeze

  def translate(item)
    if item.nil?
      '   '
    elsif item.color == :white
      WHITE_SIDE[item.type]
    else
      BLACK_SIDE[item.type]
    end
  end

  def display_board
    @board.squares.reverse.each_with_index do |row, row_index|
      print "#{(row_index - 7).abs}  ".colorize(:yellow)
      row.each do |field|
        if field.nil? || field.color == :white
          print translate(field)
        else
          print translate(field).colorize(:light_black)
        end
      end
      puts "\n"
    end
    puts '    0  1  2  3  4  5  6  7'.colorize(:yellow)
  end
end
