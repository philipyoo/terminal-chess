require_relative 'display'

class Play
  attr_reader :current_color

  def initialize
    @board = Board.new
    @display = Display.new(@board.grid)
    @current_color = :white
    @error = nil
  end

  def run_game
    intro

    until win_condition(@current_color)
      begin
        # Get Players start and end position moves for a piece
        start_pos, end_pos = nil, nil
        until start_pos && end_po
          instructions

          puts "\nCurrent Player: " +  "#{@current_player}".colorize(@current_color).bold
          puts "\n-----"

          # If an error was raised..
          if @error
            puts "\n    " + "#{@error}".colorize({:background => :red, :color => :light_yellow})
            puts "\n\n"
          end

          # Render board display
          @display.render

          # If I received start position (Player selected own piece)
          if start_pos
            puts "Selected a piece. Where do you want to move it?"
            end_pos = @display.handle_input(current_color)

            # If user pressed backspace or delete, start_pos reset
            if end_pos == "reset"
              start_pos, end_pos = nil, nil
            end
          else
            # Player needs to select a start position (Own piece)
            puts "Select a piece."
            start_pos = @display.handle_input(current_color, true)
          end
        end

        # After collecting necessary information
        # `move` method checks if move is valid. If invalid, error is raised. If valid, make move on board and switch players
        @board.move(@current_color, start_pos, end_pos)
        @error = nil
        switch_player
      rescue StandardError => e
        @error = e
        retry
      end
    end

    # Once checkmate is made...
    system("clear")
    puts "GAME OVER!"
    @display.render

    #switch player here because i'm lazy :)
    # Player is switched to display winning message for player that won
    switch_player
    puts "Congrats Player #{@current_player}! You have won!"
  end

  private

  def intro
    system("clear")
    puts "\n    Welcome to " + "Terminal Chess".colorize({:color => :white, :background => :black}) + "!\n\n"
    puts "Player One".colorize(:white).bold + ", please enter your name: "
    @player1 = gets.chomp

    system("clear")
    puts "Thank you Player #{@player1.colorize(:white).bold} and welcome to the game!"
    puts "Your color is " + "white".colorize(:white).bold + ".\n\n"

    sleep(1)

    puts "Player Two".colorize(:light_yellow).bold + ", please enter your name: "
    @player2 = gets.chomp

    system("clear")
    puts "Thank you Player #{@player2.colorize(:light_yellow).bold} and welcome to the game!"
    puts "Your color is " + "yellow".colorize(:light_yellow).bold + ".\n\n"

    @current_player = @player1
    print "Loading."

    3.times do
      print "."
      sleep(2)
    end
  end

  def instructions
    system("clear")
    puts "Instructions: "
    puts "Use the arrow keys to move the cursor."
    puts "Use the enter/return key to select a piece."
    puts "Use the delete/backspace key to de-select a piece."
    puts "Use CTRL + C to exit the game."
    puts "-----"
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
    @current_color = (@current_color == :white) ? :light_yellow : :white
  end

  # Check for checkmate
  def win_condition(color)
    @board.checkmate?(color)
  end
end

## Autorun game on console run ##
if __FILE__ == $0
  ace = Play.new
  ace.run_game
end
