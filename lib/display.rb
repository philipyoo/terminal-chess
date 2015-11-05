require 'colorize'
require 'io/console'
require_relative 'board'
require_relative 'pieces/test_piece'


class Display
  KEYSTROKES = {
    "\e[A"   => :up,
    "\e[B"   => :down,
    "\e[C"   => :right,
    "\e[D"   => :left,
    "\r"     => :return,
    "\177"   => :backspace,
    "\004"   => :delete,
    "\u0003" => :ctrl_c
  }

  MOVES = {
    left:  [0, -1],
    right: [0, 1],
    up:    [-1, 0],
    down:  [1, 0]
  }

  def initialize(grid)
    @grid = grid
    @cursor = [0, 0]
    @selected = nil
  end

  def handle_input(color, select_piece = false)
    #get users input keystroke and get the symbol
    user_input = KEYSTROKES[read_char]

    case user_input
    when :up, :down, :right, :left
      #update cursor position
      update_cursor(MOVES[user_input])
      return nil
    when :return
      if select_piece
        @selected = nil
        @selected = @cursor if @grid[@cursor[0]][@cursor[1]].color == color
      else
        @selected = @cursor if @grid[@cursor[0]][@cursor[1]].empty?
      end

      if @selected != nil
        return @cursor
      else
        return nil
      end
    when :backspace, :delete
      @selected = false
      return "reset"
    when :ctrl_c
      puts "Exiting game.."
      exit 0
    else
      puts "Key unknown"
    end

    system("clear")
    render
  end

  def find_piece
    @grid.flatten.find { |piece| piece.position == @cursor }
  end

  def update_cursor(movement)
    new_position = [@cursor[0] + movement[0], @cursor[1] + movement[1]]
    @cursor = new_position if on_board?(new_position)
  end

  def on_board?(test_position)
    test_position[0].between?(0, 7) && test_position[1].between?(0, 7)
  end

  def build_grid
    @grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color = colorize_game(i, j, piece.color)

      piece.image.colorize(color)
    end
  end

  def colorize_game(i, j, piece_color)
    if @cursor == [i, j]
      bg = :green
    elsif (i + j).odd?
      bg = :magenta
    else
      bg = :blue
    end

    if @selected && [i, j] == @selected
      bg = :light_magenta
    end

    { background: bg, color: piece_color }
  end

  def render
    puts "Board:"
    build_grid.each { |row| puts row.join }
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end


end
