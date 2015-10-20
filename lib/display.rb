require 'colorize'
require_relative 'board'
require_relative 'pieces/test_piece'


class Display
  def initialize(board)
    @grid = board
    @cursor = [0, 0]
    @selected = false
  end

  def build_grid
    @grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color = colorize_game(i, j)
      if !piece.nil?
      #   piece.colorize(color)
      # else
        piece.img.colorize(color)
      end
    end
  end

  def colorize_game(i, j)
    if @cursor == [i, j]
      bg = :red
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :blue
    end

    { background: bg, color: :white }
  end

  def render
    puts "Test:"
    build_grid.each { |row| puts row.join }
  end


end


## Driver Code Tests:

ace = Board.new

bay = Display.new(ace.board)

bay.render
