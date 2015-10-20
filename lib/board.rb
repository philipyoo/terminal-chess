


class Board
  attr_reader :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    setup_board
  end

  def move(start_pos, end_pos)
    #raise error if no piece at start_pos and/or can't move selected piece to end_pos assigned
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
