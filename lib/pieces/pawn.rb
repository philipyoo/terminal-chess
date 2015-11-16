require_relative 'piece'

class Pawn < Piece
  def symbol(color)
    "\u265F".encode('utf-8')
  end

  def valid_moves
    moves = []
    current_y, current_x = @position

    p "Pawn @position: #{@position}"

    move_dirs.each do |dir_y, dir_x|
      #make sure not blocked
      moves << ([current_y + dir_y, current_x + dir_x]) if empty?(current_y + dir_y, current_x + dir_x)
    end

    p "Pawn moves: #{moves}"

    moves
  end

  def move_dirs
    if not_moved?
      color == :white ? [[-1, 0], [-2, 0]] : [[1, 0], [2, 0]]
    else
      color == :white ? [[-1, 0]] : [[1, 0]]
    end
  end

  def not_moved?
    y, x = position

    if color == :white
      return true if y == 6
    elsif color == :light_yellow
      return true if y == 1
    end

    false
  end
end
