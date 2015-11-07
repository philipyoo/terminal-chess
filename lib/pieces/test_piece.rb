
class TestPiece
  attr_reader :img

  def initialize
    @img = " O "
  end
end

class EmptyPiece
  attr_reader :image, :color, :position

  def initialize
    @color = :default
    @image = "    "
    @position = nil
  end

  def empty?(y, x)
    true
  end

end
