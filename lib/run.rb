require_relative 'display'

class Play
  attr_reader :current_color

  def initialize
    @board = Board.new
    @display = Display.new(@board.grid)
    @current_color = :white
  end

  def run_game
    intro

    until win_condition
      begin
        start_pos, end_pos = nil, nil
        until start_pos && end_pos
          instructions
          puts "#{@current_player}".colorize(@current_color).bold
          @display.render
          puts "-----"

          if start_pos
            puts "Selected Piece. Move where?"
            end_pos = @display.handle_input(current_color)

            if end_pos == "reset"
              start_pos, end_pos = nil, nil
            end
          else
            puts "Select a piece."
            start_pos = @display.handle_input(current_color, true)
          end
        end

        @board.move(@current_color, start_pos, end_pos)
        switch_player
      rescue StandardError => e
        retry
      end
    end

    puts "GAME OVER!"
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
    @current_color = (@current_color == :white) ? :light_yellow : :white
  end

  def intro
    puts "Welcome to Terminal Chess!"
    puts "Player One".colorize(:white).bold + ", please enter your name: "
    @player1 = gets.chomp
    puts "Thank you #{@player1.colorize(:white).bold} and welcome to the game!"

    puts "Player Two".colorize(:light_yellow).bold + ", please enter your name: "
    @player2 = gets.chomp
    puts "Thank you #{@player2.colorize(:light_yellow).bold} and welcome to the game!"

    @current_player = @player1

    sleep(1)
  end

  def instructions
    # system("clear")
    puts "Instructions: "
    puts "Use the arrow keys to move the cursor."
    puts "Use the enter/return key to select a piece."
    puts "Use the delete/backspace key to de-select a piece."
    puts "Use CTRL + C to exit the game."
    puts "-----"
  end

  def win_condition
    false
  end
end

## Autorun game on console run ##
if __FILE__ == $0
  ace = Play.new
  ace.run_game
end
