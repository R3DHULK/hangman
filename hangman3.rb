class Hangman
  MAX_GUESSES = 6

  def initialize(word)
    @word = word.upcase
    @guesses = []
    @incorrect_guesses = 0
  end

  def play
    puts "Welcome to Hangman!"
    while @incorrect_guesses < MAX_GUESSES
      display_word
      print_guesses
      guess = get_guess
      if @word.include?(guess)
        puts "Correct!"
        @guesses << guess
      else
        puts "Incorrect!"
        @incorrect_guesses += 1
      end
      if won?
        puts "Congratulations, you won!"
        return
      end
    end
    puts "Sorry, you lost! The word was #{@word}."
  end

  private

  def display_word
    display = ""
    @word.chars.each do |letter|
      if @guesses.include?(letter)
        display += letter
      else
        display += "_"
      end
      display += " "
    end
    puts display
  end

  def print_guesses
    puts "Incorrect guesses: #{@incorrect_guesses}"
    puts "Previous guesses: #{@guesses.join(', ')}"
  end

  def get_guess
    loop do
      print "Guess a letter: "
      guess = gets.chomp.upcase
      if guess.length != 1
        puts "Please enter a single letter."
      elsif @guesses.include?(guess)
        puts "You already guessed that letter."
      else
        return guess
      end
    end
  end

  def won?
    @word.chars.all? { |letter| @guesses.include?(letter) }
  end
end

# Example usage:
game = Hangman.new("ruby")
game.play
