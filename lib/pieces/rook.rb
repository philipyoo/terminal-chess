require_relative 'piece'

class Rook < Piece

  def symbol(color)
    "\u265C".encode('utf-8')
  end

  def move_dirs
  end
end
