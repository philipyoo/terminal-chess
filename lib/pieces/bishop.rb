
class Bishop
  attr_reader :image

  def initialize(color, position)
    @color, @position = color, position
    @image = " B "
  end

  def move_dirs
  end
end
