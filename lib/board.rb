require_relative 'pieces/test_piece'

class Board
  attr_reader :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    setup_board
  end

  def move(start_pos, end_pos)
    #updates pieces on board
  end

  private

  def setup_board
    rows = [0, 1, 6, 7]

    rows.each do |row|
      @board[row].map! { TestPiece.new }
    end
  end

end

ace = Board.new
p ace.board
