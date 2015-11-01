
class TestPiece
  attr_reader :img

  def initialize
    @img = " O "
  end
end

class EmptyPiece
  attr_reader :image

  def initialize
    @image = "    "
  end
end
