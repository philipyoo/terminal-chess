require_relative 'display'
require 'colorize'

class Play
  def initialize
    @board = Board.new
    @grid = Display.new(@board.grid)
    @current_player = @player1
    @current_color = :white
  end

  def run_game
    intro

    while !win_condition
      instructions
      puts "#{@current_player}".colorize(@current_color).bold
      @grid.render

      switch_player
    end

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

    sleep(2)
  end

  def instructions
    system("clear")
    puts "Instructions: "
    puts "Use the arrow keys to move the cursor."
    puts "Use the enter/return key to select a piece."
    puts "Use the delete/backspace key to de-select a piece."
    puts "Use CTRL + C to exit the game."
    puts "------"
  end

  def win_condition
  end
end


## Driver Code Tests:

ace = Play.new
ace.run_game
