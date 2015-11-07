require_relative 'piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_grid
  end

  def [](position)
    y, x = position
    @grid[y][x]
  end

  def []=(position, piece)
    y, x = position
    @grid[y][x] = piece
  end

  def move(color, start_pos, end_pos)
    #raise error if no piece at start_pos and/or can't move selected piece to end_pos assigned
    piece = self[start_pos]

    p "board piece: #{piece}"
    p "board piece moves: #{piece.valid_moves}"



    #If !check?
    if piece.valid_moves.include?(end_pos)
      move_piece!(start_pos, end_pos)
    else
      raise StandardError, "Invalid move"
    end
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]

    self[end_pos] = piece
    piece.position = end_pos
    self[start_pos] = EmptyPiece.new

    p "------"
    p "piece: #{piece}"
    p "start_pos: #{start_pos}"
    p "start: #{self[start_pos]}"
    p "end_pos: #{end_pos}"
    p "end: #{self[end_pos]}"
    p "piece.position: #{piece.position}"
    p "------"

    nil
  end

  def empty?(y, x)
    self.empty?(y, x)
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

    @grid[i].each.with_index do |el, j|
      @grid[i][j] = Pawn.new(color, [i, j], @grid)
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
