
class Pawn
  attr_reader :image, :color

  def initialize(color, position)
    @color, @position = color, position
    @image = " #{symbol(color)}  "
  end

  def symbol(color)
    "\u265F".encode('utf-8')
  end

  def move_dirs
  end
end
