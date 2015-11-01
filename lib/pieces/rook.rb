
class Rook
  attr_reader :image

  def initialize(color, position)
    @color, @position = color, position
    @image = " R "
  end

  def move_dirs
  end
end
