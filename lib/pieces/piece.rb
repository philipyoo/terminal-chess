require_relative 'slideable'
require_relative 'stepable'

class Piece
  attr_reader :image, :color
  attr_accessor :position

  def initialize(color, position, grid)
    @color, @position, @grid = color, position, grid
    @image = " #{symbol(color)}  "
  end

  def pos(position)
    raise "nil error" if position.include?(nil)

    y, x = position
    @grid[y][x]
  end

  def empty?(position) # checks if empty space
    pos(position).is_a?(EmptyPiece)
  end

  def move_makes_check?(to_position) #if piece moved puts your king in check
  end

end
