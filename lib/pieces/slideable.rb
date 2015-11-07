
module Slideable
  DIAGONAL = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  STRAIGHT = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  def dirs_diagonal
    DIAGONAL
  end

  def dirs_straight
    STRAIGHT
  end
end
