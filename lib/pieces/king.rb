require_relative 'piece'

class King < Piece
  def symbol(color)
    "\u265A".encode('utf-8')
  end

  def move_dirs
  end
end
