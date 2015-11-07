require_relative 'piece'

class King < Piece
  include Stepable

  def symbol(color)
    "\u265A".encode('utf-8')
  end

  def dirs
    [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
  end
end
