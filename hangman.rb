class Hangman
  def initialize the_word, input=UserInput, ui=CLI
    @the_word = the_word.downcase
    @progress = '*' * @the_word.length
    @guesses = 6
    @previous_guesses = []
    @input = input
    @ui = ui
  end

  def play_turn
    @ui.display "Previous guesses: #{@previous_guesses}"
    @ui.display "Guesses left: #{@guesses}"
    @ui.display "Progress: #{@progress}"
    guess = @input.get_guess


    alphabetical_regex = /[a-zA-Z]/
    if guess.length != 1 || !alphabetical_regex.match(guess)
      @ui.display "Guesses must be exactly one letter"
      return
    end

    if @previous_guesses.include? guess
      @ui.display "You already guessed that!"
      return
    end

    @previous_guesses << guess

    if @the_word.include? guess
      @the_word.split('').each_with_index do |letter, idx|
        if letter == guess
          @progress[idx] = letter
        end
      end
    else
      @guesses -= 1
    end
  end

  def ended?
    won? || lost?
  end

  def won?
    @the_word == @progress
  end

  def lost?
    @guesses.zero?
  end
end

class HangmanGame

  def initialize options={}
    @input = options[:input] || UserInput
    @ui = options[:ui] || CLI
  end

  def play
    hangman = Hangman.new('onoMATopoEIA', @input, @ui)
    while !hangman.ended?
      hangman.play_turn
    end

    if hangman.won?
      @ui.display "you win!"
    else
      @ui.display "you lose!"
    end
  end

  def play_again?
    @ui.display "Would you like to play again? y/n"
    return gets.chomp.downcase == 'y'
  end

  def start
    play
    while play_again?
      play
    end
  end
end

class UserInput
  def self.get_guess
    gets.chomp.downcase
  end
end

class AIInput
  def self.get_guess
    ("a".."z").to_a.sample
  end
end

class CLI
  def self.display message
    puts message
  end
end

class FileOutput
  def self.display message
    File.open('output.txt', 'a') do |f|
      f.puts message
    end
  end
end

HangmanGame.new({input: AIInput, ui: CLI}).start
