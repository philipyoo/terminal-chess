require_relative 'slideable'


class Queen
  include Slideable

  def symbol
    " Q "
  end

  def move_dirs
    dirs_diagonal + dirs_straight
  end
end
