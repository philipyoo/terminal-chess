
module Slideable
  DIAGONAL = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  STRAIGHT = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  def dirs_diagonal
    DIAGONAL
  end

  def dirs_straight
    STRAIGHT
  end

  def valid_moves
    moves = []

    move_dirs.each do |dir_y, dir_x|
      moves.concat(unblocked_moves(dir_y, dir_x))
    end

    moves
  end

  def unblocked_moves(dir_y, dir_x)
    current_y, current_x = @position

    p "Start y, x: #{current_y}, #{current_x}"

    moves = []

    loop do
      current_y += dir_y
      current_x += dir_x


      break unless valid_position?([current_y, current_x])  #on the board?

      p "Current y, x: #{current_y}, #{current_x}"
      if valid_position?([current_y, current_x])
        p "TESTER: #{@grid[current_y][current_x]}"
        p "position[6][2]: #{@grid[6][2]}"
      end

      if empty?(current_y, current_x)  # space is unoccupied?
        moves << [current_y, current_x]
      else
        moves << [current_y, current_x] if @color != position_color(current_y, current_x)
        break   # can't move past a blocking piece
      end
    end

    puts "unblocked_moves: #{moves}"

    moves
  end
end
