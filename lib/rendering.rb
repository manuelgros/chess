# frozen_string_literal: true

require 'colorize'

# Module to render the chess game for display in console
module Rendering
  SKINS = {
    rook: ' R ',
    knight: ' K ',
    bishop: ' B ',
    queen: ' Q ',
    king: ' K ',
    pawn: ' P '
  }.freeze

  def translate(item)
    return '   ' if item.nil?

    SKINS[item.type]
  end

  def display_board
    @board.squares.each_with_index do |row, row_index|
      print "#{row_index}  ".colorize(:yellow)
      row.each { |field| print translate(field) }
      puts "\n"
    end
    puts '    0  1  2  3  4  5  6  7'.colorize(:yellow)
  end
end
