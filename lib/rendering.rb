# frozen_string_literal: true

require 'colorize'
require 'colorized_string'

# Module to render the chess game for display in console
module Rendering
  # Different version of black side pieces
  # BLACK_SIDE = {
  #   king: " \u265a ".colorize(:red),
  #   queen: " \u265b ".colorize(:red),
  #   rook: " \u265c ".colorize(:red),
  #   bishop: " \u265d ".colorize(:red),
  #   knight: " \u265e ".colorize(:red),
  #   pawn: " \u265f ".colorize(:red)
  # }.freeze

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
    if item.type == :empty
      '   '
    elsif item.color == :white
      WHITE_SIDE[item.type]
    else
      BLACK_SIDE[item.type]
    end
  end

  def color_square(field_color, field)
    return ColorizedString[field].on_white if field_color == :white

    ColorizedString[field].on_black
  end

  def display_row(field_color, row)
    row.each do |field|
      symbol = translate(field)
      print color_square(field_color, symbol)
      field_color = field_color == :white ? :black : :white
    end

    puts "\n"
  end

  def display_board
    field_color = :black
    @board.squares.reverse.each_with_index do |row, row_index|
      print "#{(row_index - 7).abs}  ".colorize(:yellow)
      display_row(field_color, row)
      field_color = field_color == :white ? :black : :white
    end
    puts '    0  1  2  3  4  5  6  7'.colorize(:yellow)
  end

  def simple_display_board
    @board.squares.reverse.each_with_index do |row, row_index|
      print "#{(row_index - 7).abs}  ".colorize(:yellow)
      row.each do |field|
        print translate(field)
      end
      puts "\n"
    end
    puts '    0  1  2  3  4  5  6  7'.colorize(:yellow)
  end
end
