# frozen_string_literal: true

module Mastermind
  # keeps track of the game state
  class Game
    def initialize(player_1_class, player_2_class)
      @secret
      # @guesses = []
      # @clues = []
      # @round = 12
      @current_player_id = 0
      # @players = [player_1_class, player_2_class]
    end

    def player_win?(player_guess)
      # player guess == @secret
      # codebreaker == rounds up
    end

    def play
      loop do
        querry_player(current_player)

        if player_win?(current_player)
          puts "#{current_player} wins!"
          return
        end

        switch_players!
      end
      # game logic
      # loop do
      # ask for guess
      # check guess
    end

    def other_player_id
      1 - @current_player_id
    end

    def switch_players!
      @current_player_id = other_player_id
    end
  end

  # keeps track of player states
  class Player
    def initialize(name)
      @name = name
    end
    attr_reader :name
  end

  # secretmaker
  class Secretmaker < Player
    def create_secret
      # generate 4 digit random number
      number_string = rand(9999).to_s
      if number_string.size < 4
        add_zero = 4 - number_string.size
        ('0' * add_zero) + number_string
      end
    end
  end

  # codebreaker
  class Codebreaker < Player
    def create_secret
      loop do
        print 'please select a 4 digit seceret code: '
        selection = gets.chomp
        return selection if selection.size == 4 && selection.to_i != 0

        puts "The seceret '#{selection}' is not valid"
      end
    end
  end
end

include Mastermind

puts Secretmaker.new("Gert").create_secret


# computer randomly gens a 4 digit code
# ask players name
# ask players.name guess
# remove one round
# computer evals and returns clues
#   - A for right place and number
#   - B for right number but wrong place
