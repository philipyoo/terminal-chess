require_relative 'piece'

class Queen < Piece
  include Slideable

  def symbol(color)
    "\u265B".encode('utf-8')
  end

  def move_dirs
    dirs_diagonal + dirs_straight
  end


end
