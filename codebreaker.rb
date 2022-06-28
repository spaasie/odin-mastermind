module Codebreaker
  # game logic
  class Game
    attr_reader :secret, :guesses, :current_player_id, :clues

    def initialize(computer_class, human_class)
      @players = [computer_class.new('computer'), human_class.new('human')]
      @current_player_id = 0
      @secret = @players[0].create_code
      @guesses = []
      @clues = []
    end

    def play
      rounds = 12
      loop do
        if guesses.size == rounds
          puts 'rounds are up'
          return
        end

        if computer?
          if guesses.last == secret
            puts "You win the secret is #{secret}"
            return
          end
          puts 'hello im a computer'
          # eval guess
          eval_guess if guesses.size.positive?

        elsif human?
          puts "You have #{rounds - guesses.size} rounds left"
          guesses.each_with_index do |guess, i|
            puts "#{guess} clues: #{clues[i]}"
          end
          puts 'have a guess'
          print '> '
          guess(gets.chomp)
        end
        switch!
      end
    end

    def eval_guess
      secret_arr = secret.split('')
      guess_arr = guesses.last.split('')
      a = 0
      b = 0
      a_indexes = []
      secret_arr.each_with_index do |element, i|
        if element == guess_arr[i]
          a += 1
          a_indexes.push(i)
        end
      end
      a_indexes.reverse.each do |e|
        secret_arr.delete_at(e)
        guess_arr.delete_at(e)
      end
      # check remainder for the 'B'
      secret_arr.each do |element|
        b += 1 if guess_arr.include?(element)
      end
      clues.push("A#{a} B#{b}")
    end

    def guess(guess)
      @guesses.push(guess)
    end

    def computer?
      return true if current_player.type == 'computer'

      false
    end

    def human?
      return true if current_player.type == 'human'

      false
    end

    def current_player
      @players[current_player_id]
    end

    def other_player_id
      1 - @current_player_id
    end

    def switch!
      @current_player_id = other_player_id
    end
  end

  # human player
  class Human
    attr_reader :name, :type

    def initialize(name)
      @name = name
      @type = 'human'
    end
  end

  # computer ai
  class Computer
    attr_reader :name, :type

    def initialize(name)
      @name = name
      @type = 'computer'
    end

    # create 4 digit code
    def create_code
      code = rand(9999).to_s
      if code.size < 4
        spaces = 4 - code.size
        code = ('0' * spaces) + code
      end
      code
    end
  end
end

include Codebreaker

game = Game.new(Computer, Human).play

  # game.play
