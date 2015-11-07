require_relative 'slideable'
require_relative 'stepable'

class Piece
  attr_reader :image, :color
  attr_accessor :position

  def initialize(color, position, grid)
    @color, @position, @grid = color, position, grid
    @image = " #{symbol(color)}  "
  end

  def empty?(y, x) # checks if empty space
    @grid[y][x].is_a?(EmptyPiece)
  end

  def valid_position?(coords)
    coords.all? { |coord| coord.between?(0, 7) }
  end

  def move_makes_check?(to_position) #if piece moved puts your king in check
  end

end
