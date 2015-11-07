require_relative 'piece'

class Knight < Piece
  def symbol(color)
    "\u265E".encode('utf-8')
  end

  def move_dirs
  end
end
