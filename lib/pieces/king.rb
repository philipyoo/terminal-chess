
class King
  attr_reader :image

  def initialize(color, position)
    @color, @position = color, position
    @image = " K "
  end

  def move_dirs
  end
end
