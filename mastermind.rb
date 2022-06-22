# frozen_string_literal: true

module Mastermind
  # keeps track of the game state
  class Game
    def initialize(player_1_class, player_2_class)
      # @secret
      # @guesses = []
      # @clues = []
      # @round = 12
      # @players = [player_1_class, player_2_class]
    end

    def player_win?(player_guess)
      # player guess == @secret
    end

    def play
      # game logic
      # loop do
      # ask for guess
      # check guess
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
      loop do
        print 'please select a 4 digit seceret code: '
        selection = gets.chomp
        return selection if selection.size == 4 && selection.to_i != 0

        puts "The seceret '#{selection}' is not 4 digits long"
      end
    end
  end

  # codebreaker
  class Codebreaker < Player
  end
end

include Mastermind

gert = Secretmaker.new("Gert").create_secret
