
class King
  attr_reader :image, :color

  def initialize(color, position)
    @color, @position = color, position
    @image = " #{symbol(color)}  "
  end

  def symbol(color)
    "\u265A".encode('utf-8')
  end

  def move_dirs
  end
end
