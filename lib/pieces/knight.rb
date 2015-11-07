require_relative 'piece'

class Knight < Piece
  include Stepable

  def symbol(color)
    "\u265E".encode('utf-8')
  end

  def dirs
    [[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2]]
  end
end
