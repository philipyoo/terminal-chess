
class King
  attr_reader :image

  def initialize(color, position)
    @color, @position = color, position
    @image = " #{symbol(color)}  "
  end

  def symbol(color)
    unicode = color == :white ? "\u2654" : "\u265A"
    unicode.encode('utf-8')
  end

  def move_dirs
  end
end
