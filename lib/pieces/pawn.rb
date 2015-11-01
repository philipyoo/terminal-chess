
class Pawn
  attr_reader :image

  def initialize(color, position)
    @color, @position = color, position
    @image = " P "
  end

  def move_dirs
  end
end
