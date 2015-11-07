require_relative 'piece'

class Bishop < Piece
  include Slideable

  def symbol(color)
    "\u265D".encode('utf-8')
  end

  def move_dirs
    dirs_diagonal
  end
end
