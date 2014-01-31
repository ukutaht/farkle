# encoding: UTF-8
module Farkle
  class CLI_Presenter
    SCREEN =  <<-STRING
                                   CURRENT_PLAYER's turn

                                           DICE
 no.         1            2            3            4            5            6
          +-----+      +-----+      +-----+      +-----+      +-----+      +-----+
 value    |  *  |      |  *  |      |  *  |      |  *  |      |  *  |      |  *  |
          +-----+      +-----+      +-----+      +-----+      +-----+      +-----+

                        +------------------------------------------+
                        INFO
                        +------------------------------------------+
        STRING
    attr_reader :game
    def initialize(game)
      @game = game
    end

    def start_game
      system 'clear'
      puts "Welcome to the super amazing Farkle™!"
      puts "Enter the names of the players, seperated by commas"
      game.players = gets.chomp.split(",").map{|name| Farkle::Player.new(name)}
    end

    def draw_screen(info_text)
      screen = SCREEN.dup
      game.dice.each do |die|
        screen.sub!("*", die.scored ? "X" : die.value.to_s)
      end
      screen.sub!("CURRENT_PLAYER", game.current_player.name)
      screen.sub!("INFO", info_text)
      system 'clear'
      puts screen
    end

    def show_score(score)
      draw_screen "You scored #{score} points!"
      sleep(1)
    end

    def bank_score?(score)
      draw_screen "Bank the #{score} points you have accumulated in this turn?(y/n)"
      gets.chomp == "y"
    end

    def get_selection
      draw_screen "Enter the dice you wish to select, separated by commas"
      indices = gets.chomp.split(",").map{|no| no.to_i - 1}
      indices.map do |i|
        game.dice[i]
      end
    end

    def farkle
      draw_screen "Farkle! You scored 0 points from this turn"
      sleep(2)
    end

    def dieroll
      draw_screen "Dieroll.."
      sleep(1)
    end

    def present_winner
      "WINININNN"
    end

  end
end