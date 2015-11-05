require_relative 'piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_grid
  end

  def move(color, start_pos, end_pos)
    #raise error if no piece at start_pos and/or can't move selected piece to end_pos assigned
    #updates pieces on grid
  end

  def empty?
    self[position].empty?
  end



  private

  def back_rows(color)
    back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    i = (color == :white) ? 7 : 0

    back_pieces.each_with_index do |piece, j|
      @grid[i][j] = piece.new(color, [i, j], @grid)
    end

  end

  def pawn_rows(color)
    i = (color == :white) ? 6 : 1

    @grid[i].map! do |j|
      Pawn.new(color, [i, j], @grid)
    end
  end

  def empty_rows
    rows = [2, 3, 4, 5]

    rows.each do |row|
      @grid[row].map! { EmptyPiece.new }
    end
  end

  def setup_grid
    empty_rows
    [:white, :light_yellow].each do |color|
      back_rows(color)
      pawn_rows(color)
    end
  end

end
