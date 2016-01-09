
# Used for King and Knight
module Stepable
  def valid_moves
    moves = []
    current_y, current_x = @position

    dirs.each do |dir_y, dir_x|
      new_y = current_y + dir_y
      new_x = current_x + dir_x

      moves << ([new_y, new_x]) if conditionals?(new_y, new_x)
    end

    moves
  end

  private

  def conditionals?(y, x)
    if valid_position?([y, x])
      return true if empty?(y, x) || @grid[y][x].color != @color
    end

    false
  end
end
