
# Used for Queen, Bishop, Rook
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

  private

  # Slideable pieces cannot jump over their own color pieces and they can't surpass enemy pieces, but can capture enemy piece
  def unblocked_moves(dir_y, dir_x)
    current_y, current_x = @position

    moves = []

    loop do
      current_y += dir_y
      current_x += dir_x

      break if !valid_position?([current_y, current_x])

      if empty?(current_y, current_x)  # space is unoccupied?
        moves << [current_y, current_x]
      else
        moves << [current_y, current_x] if @color != position_color?(current_y, current_x)
        break   # can't move past a blocking piece
      end
    end

    moves
  end
end
