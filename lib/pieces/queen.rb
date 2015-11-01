


class Queen
  attr_reader :image

  def initialize(color, position)
    @color, @position = color, position
    @image = " #{symbol(color)}  "
  end

  def symbol(color)
    unicode = color == :white ? "\u2655" : "\u265B"
    unicode.encode('utf-8')
  end

  def move_dirs
  end
end
