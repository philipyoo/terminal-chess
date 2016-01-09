require_relative 'slideable'
require_relative 'stepable'

# All shared functionality of every piece. Parent class
class Piece
  attr_reader :image, :color
  attr_accessor :position

  def initialize(color, position, grid)
    @color, @position, @grid = color, position, grid
    @image = " #{symbol(color)}  "
  end

  def empty?(y, x)
    @grid[y][x].is_a?(EmptyPiece)
  end

  def position_color?(y, x)
    if valid_position?([y, x])
      @grid[y][x].color
    end
  end

  def valid_position?(coords)
    coords.all? { |coord| coord.between?(0, 7) }
  end

end
