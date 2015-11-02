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
      color = colorize_game(i, j, piece.color)
      if piece.is_a?(EmptyPiece)    # piece exists
        piece.image.colorize(color)
      else
        piece.image.colorize(color)
      end
    end
  end

  def colorize_game(i, j, piece_color)
    if @cursor == [i, j]
      bg = :green
    elsif (i + j).odd?
      bg = :magenta
    else
      bg = :blue
    end

    { background: bg, color: piece_color }
  end

  def render
    puts "Board:"
    build_grid.each { |row| puts row.join }
  end


end


## Driver Code Tests:

ace = Board.new

bay = Display.new(ace.board)

bay.render
