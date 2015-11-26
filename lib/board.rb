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
    piece = self[start_pos]

    p "board piece: #{piece}"
    p "board piece moves: #{piece.valid_moves}"

    #if I'm put in_check?  #need to somehow notify player that he/she is still in_check?
    ## move on dupe board
    ## check if still in_check?
    ### if so, raise StandardError, "King still in check"
    ## else if not in_check?
    ### move on @grid board

    if piece.valid_moves.include?(end_pos)

        move_piece!(start_pos, end_pos)
      # end
    else
      raise StandardError, "Invalid move"
    end
  end

  def move_conditionals(piece, start_pos, end_pos)
    dupe_board

    # piece.valid_moves.include?(end_pos) &&

  end

  def move_piece!(start_pos, end_pos)
    p "*" * 100
    p self

    piece = self[start_pos]

    self[end_pos] = piece
    piece.position = end_pos
    self[start_pos] = EmptyPiece.new

    p "------"
    # p check_grid(find_king)
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

  def position_color?(y, x)
    self.position_color?(y, x)
  end

  def in_check?(board)
    all_opponent_moves.include?(find_king)
  end

  def checkmate?
    return true if in_check?(@grid) && any_king_moves?
  end

  def all_opponent_moves
    all_moves = []

    p self
    p "?" * 100

    # TODO: color??
    # opp_pieces = all_pieces.select { |piece| piece.color != current_color }

    # opp_pieces.each do |piece|
    #   all_moves.concat(piece.valid_moves)
    # end

    all_moves
  end

  # find all pieces on the board... Helper method
  def all_pieces
    @grid.flatten.find_all { |pos| !pos.is_a?(EmptyPiece) }
  end

  def find_king
    # all_pieces.find { |piece| piece.color == current_color && piece.is_a?(King) }
  end

  # used to find if any king moves are available. This also checks if a kings valid_moves puts the king in check
  def any_king_moves?
    (find_king.valid_moves - all_opponent_moves).length == 0
  end

  def dupe_board
    temp_board = Array.new(8) { Array.new(8) }

    temp_board.each do |row, y|
      row.each do |piece, x|
        piece = @grid[y][x]
      end
    end

    temp_board
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
