
class Rook
  attr_reader :image

  def initialize(color, position)
    @color, @position = color, position
    @image = " #{symbol(color)}  "
  end

  def symbol(color)
    unicode = color == :white ? "\u2656" : "\u265C"
    unicode.encode('utf-8')
  end

  def move_dirs
  end
end
