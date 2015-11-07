require_relative 'piece'

class Rook < Piece
  include Slideable

  def symbol(color)
    "\u265C".encode('utf-8')
  end

  def move_dirs
    dirs_straight
  end
end
