# frozen_string_literal: true

require 'colorize'

# Module to render the chess game for display in console
module Rendering
  SKINS = {
    rook: ' R ',
    knight: ' N ',
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
