
# Class used initially to fill and test board
class TestPiece
  attr_reader :img

  def initialize
    @img = " O "
  end
end

# Object class used for empty spaces on board
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
