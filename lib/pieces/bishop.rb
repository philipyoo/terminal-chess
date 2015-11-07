require_relative 'piece'

class Bishop < Piece
  def symbol(color)
    "\u265D".encode('utf-8')
  end

  def move_dirs
  end
end
