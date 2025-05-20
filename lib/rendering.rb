# frozen_string_literal: true

require 'colorize'

# Module to render the chess game for display in console
module Rendering
  def display_board
    @board.squares.each_with_index do |row, row_index|
      print "#{row_index}  ".colorize(:yellow)
      row.each { |field| print translate(field) }
      puts "\n"
    end
    puts '    0  1  2  3  4  5  6  7'.colorize(:yellow)
  end

  def translate(item)
    return '   ' if item.nil?

    case item.type
    when :rook then ' R '
    when :knight then ' K '
    when :bishop then ' B '
    when :queen then ' Q '
    when :king then ' H '
    when :pawn then ' P '
    end
  end
end
