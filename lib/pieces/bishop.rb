
class Bishop
  attr_reader :image

  def initialize(color, position)
    @color, @position = color, position
    @image = " #{symbol(color)}  "
  end

  def symbol(color)
    unicode = color == :white ? "\u2657" : "\u265D"
    unicode.encode('utf-8')
  end

  def move_dirs
  end
end
