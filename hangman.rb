class Hangman
  def initialize the_word
    @the_word = the_word.downcase
    @progress = '*' * @the_word.length
    @guesses = 6
    @previous_guesses = []
  end

  def play
    while true
      puts "Previous guesses: #{@previous_guesses}"
      puts "Guesses left: #{@guesses}"
      puts "Progress: #{@progress}"
      guess = gets.chomp.downcase


      alphabetical_regex = /[a-zA-Z]/

      if guess.length != 1 || !alphabetical_regex.match(guess)
        puts "Guesses must be exactly one letter"
        next
      end

      if @previous_guesses.include? guess
        puts "You already guessed that!"
        next
      end
      @previous_guesses << guess

      if @the_word.include? guess
        @the_word.split('').each_with_index do |letter, idx|
          if letter == guess
            @progress[idx] = letter
          end
        end
        if @the_word == @progress
          puts "you win!"
          return
        end
      else
        @guesses -= 1
        if @guesses.zero?
          puts "you lose!"
          return
        end
      end
    end
  end
end

Hangman.new('onoMATopoEIA').play
