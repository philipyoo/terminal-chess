require_relative 'piece'

class Board
  attr_reader :grid

  def initialize(fill_board = true)
    @grid = Array.new(8) { Array.new(8) }

    if fill_board
      setup_grid
    end
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

    test_board = dupe_board

    if piece.valid_moves.include?(end_pos)
      #move on duped board
      move_piece!(start_pos, end_pos, test_board)
      king_pos = test_board.find_king(color)
      opponent_moves = test_board.all_opponent_moves(color)

      if in_check?(king_pos, opponent_moves)
        #invalid move
        raise StandardError, "Can't move there. King will be in check."
      else
        move_piece!(start_pos, end_pos)
      end

    else
      raise StandardError, "Invalid move"
    end
  end

  def move_piece!(start_pos, end_pos, board = self)
    piece = board[start_pos]

    board[end_pos] = piece
    piece.position = end_pos
    board[start_pos] = EmptyPiece.new

    nil
  end

  def empty?(y, x)
    self.empty?(y, x)
  end

  def in_check?(king_pos, opp_moves)
    opp_moves.include?(king_pos)
  end

  def checkmate?(color)
    king_pos = self.find_king(color)
    opponent_moves = self.all_opponent_moves(color)

    return true if in_check?(king_pos, opponent_moves) && any_king_moves?(king_pos, opponent_moves) && still_in_check?(color)
  end

  def still_in_check?(color)
    # TODO: this is gonna take up a ton of memory. Need to refactor this somehow

    #for each of my pieces, move and check if still in_check?
    all_pieces(color).each do |piece|
      piece.valid_moves.each do |move|
        test_board = dupe_board

        move_piece!(piece.position, move, test_board)
        king_pos = test_board.find_king(color)
        opp_moves = test_board.all_opponent_moves(color)

        return false if !in_check?(king_pos, opp_moves)
      end
    end

    true
  end

  def all_pieces(color)
    self.grid.flatten.select{ |piece| piece.color == color }
  end

  def all_opponent_moves(color)
    all_moves = []

    opp_pieces = self.grid.flatten.select do |piece|
      if piece.color
        piece.color == opponent_color(color)
      end
    end

    all_moves.concat(opp_pieces.map { |piece| piece.valid_moves }).select { |arr| arr.length > 0 }

    all_moves.flatten(1)
  end

  def opponent_color(color)
    color == :white ? :light_yellow : :white
  end

  def find_king(color)
    self.grid.flatten.find_all { |loc| loc.is_a?(King) }.select { |piece| piece.color == color}.map { |piece| piece.position }.flatten
  end

  # used to find if any king moves are available. This also checks if a kings valid_moves puts the king in check
  def any_king_moves?(king_pos, opp_moves)
    opp_color = opponent_color(self[king_pos].color)

    (self[king_pos].valid_moves - all_opponent_moves(opp_color)).length == 0
  end

  def dupe_board
    temp_board = Board.new(false)

    @grid.each.with_index do |row, y|
      row.each.with_index do |piece, x|
        if piece.class == EmptyPiece
          temp_board.grid[y][x] = EmptyPiece.new
        else
          temp_board.grid[y][x] = piece.class.new(piece.color, [y, x], temp_board.grid)
        end
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
