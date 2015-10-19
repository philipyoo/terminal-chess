require 'colorize'
require_relative 'board'


class Display
  def initialize(board)
    @board = board
    @cursor = [0, 0]
    @selected = false
  end


end
