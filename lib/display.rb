require 'colorize'
require 'io/console'
require_relative 'board'

class Display
  # I/O keys
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

  # After I/O arrow key is made, these are the [y, x] moves made on board
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
    #get users input keystroke and set `user_input` to the symbol
    user_input = KEYSTROKES[read_char]

    # I/O key mapping results
    case user_input
    when :up, :down, :right, :left
      #update cursor position
      update_cursor(MOVES[user_input])
      return nil
    when :return
      # if this move is to select a piece (called from Play class)
      if select_piece
        # reset `@selected` each time the player has to reselect a piece due to error or invalid moves
        @selected = nil

        # @selected if the piece is players' color
        @selected = @cursor if @grid[@cursor[0]][@cursor[1]].color ==  color
      else
        # move piece to a valid position
        @selected = @cursor if @grid[@cursor[0]][@cursor[1]].empty?(@cursor[0], @cursor[1])
      end

      # If @selected is set, then return @cursor, can also return @selected. Both should work
      return @selected != nil ? @cursor : nil
    when :backspace, :delete
      @selected = false
      return "reset"
    when :ctrl_c
      puts "Exiting game.."
      exit 0
    else
      puts "Key unknown"
    end
  end

  def render
    build_grid.each { |row| puts row.join }
  end

  private

  # Build Grid ("Board")
  def build_grid
    @grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  # Helper method for `build_grid`
  # Creates each row and colors it
  def build_row(row, i)
    row.map.with_index do |piece, j|
      color = colorize_game(i, j, piece.color)

      # Get each image of a piece and color it
      piece.image.colorize(color)
    end
  end

  # Colors in the background of the board
  def colorize_game(i, j, piece_color)
    if @cursor == [i, j]
      bg = :green
    elsif (i + j).odd?
      bg = :magenta
    else
      bg = :blue
    end

    # If users selection location matches current [i, j] location on board, highlight background differently to show either current selected or opponents last move
    if [i, j] == @selected
      bg = :light_magenta
    end

    # Return a hash for colorize gem to set background color and piece color
    { background: bg, color: piece_color }
  end

  # Used to make sure cursor is only able to move around on the board, and not be able to go off of it
  def on_board?(test_position)
    test_position[0].between?(0, 7) && test_position[1].between?(0, 7)
  end

  # Updates cursor highlighting on board
  def update_cursor(movement)
    new_position = [@cursor[0] + movement[0], @cursor[1] + movement[1]]
    @cursor = new_position if on_board?(new_position)
  end

  # I/O functionality
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
