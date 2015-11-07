
module Stepable
  def valid_moves
    moves = []
    current_y, current_x = @position

    p "hiiiiiiiiiii"

    p dirs
    p "Current: #{current_y}, #{current_x}"

    p "Stepable @position: #{@position}"


    dirs.each do |dir_y, dir_x|
      p "dir: #{dir_y}, #{dir_x}"
      new_y = current_y + dir_y
      new_x = current_x + dir_x
      p "new: #{new_y}, #{new_x}"
      # p "conditionals: #{conditionals?([new_y, new_x])}"
      moves << ([new_y, new_x]) if conditionals?(new_y, new_x)
    end

    p "Stepable moves: #{moves}"

    moves
  end

  def conditionals?(y, x)
    #valid position and occupied w/ color
    if valid_position?([y, x])
      return true if empty?(y, x) || @grid[y][x].color != @color
    end
    false
  end
end
