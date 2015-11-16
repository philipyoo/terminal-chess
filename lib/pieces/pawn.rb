require_relative 'piece'

class Pawn < Piece
  def symbol(color)
    "\u265F".encode('utf-8')
  end

  def valid_moves
    moves = []
    current_y, current_x = @position

    move_dirs.each do |dir_y, dir_x|
      new_y = current_y + dir_y
      new_x = current_x + dir_x

      moves << ([new_y, new_x]) if empty?(new_y, new_x)
    end

    attack_moves.each do |dir_y, dir_x|
      new_y = current_y + dir_y
      new_x = current_x + dir_x

      moves << ([new_y, new_x]) if position_color(new_y, new_x) == opponent_color
    end

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

  def opponent_color
    color == :white ? :light_yellow : :white
  end

  def attack_moves
    color == :white ? [[-1, -1], [-1, 1]] : [[1, 1], [1, -1]]
  end
end
