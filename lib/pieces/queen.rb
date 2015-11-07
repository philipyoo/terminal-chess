require_relative 'piece'

class Queen < Piece
  include Slideable

  def symbol(color)
    "\u265B".encode('utf-8')
  end

  def move_dirs
    dirs_diagonal + dirs_straight
  end

  def valid_moves
    moves = []

    p "Queen @position: #{@position}"

    move_dirs.each do |dir_y, dir_x|
      moves.concat(unblocked_moves(dir_y, dir_x))
    end

    p "Queen moves: #{moves}"

    moves
  end

  def valid_position?(coords)
    coords.all? { |coord| coord.between?(0, 7) }
  end

  def unblocked_moves(dir_y, dir_x)
    current_y, current_x = @position

    p "Start y, x: #{current_y}, #{current_x}"

    moves = []

    loop do
      current_y += dir_y
      current_x += dir_x

      tester = defined? @grid.empty?(pos)


      break unless valid_position?([current_y, current_x])  #on the board?

      p "Current y, x: #{current_y}, #{current_x}"
      if valid_position?([current_y, current_x])
        p "TESTER: #{@grid[current_y][current_x]}"
        p "position[6][2]: #{@grid[6][2]}"
      end

      if empty?(current_y, current_x)  # space is unoccupied?
        moves << [current_y, current_x]
      # else
      #   moves << pos if @grid[pos].color != @color
      #   break   # can't move past a blocking piece
      end
    end

    puts "unblocked_moves: #{moves}"

    moves
  end

  def can_take?(position)
    if @color != @grid[position].color #other pieces color
    end
  end


end
