
class TestPiece
  attr_reader :img

  def initialize
    @img = " O "
  end
end

class EmptyPiece
  attr_reader :image, :color

  def initialize
    @color = :default
    @image = "    "
  end
end
