class Hangman
  def initialize(word)
    @word = word
    @guesses = []
    @incorrect_guesses = 0
    @max_guesses = 6
  end

  def play
    puts "Welcome to Hangman!"
    puts "The word has #{word.length} letters."
    loop do
      display_word
      puts "Guess a letter: "
      guess = gets.chomp.downcase
      if @word.include?(guess)
        @guesses << guess
        if won?
          display_word
          puts "You win!"
          break
        end
      else
        @incorrect_guesses += 1
        if lost?
          puts "You lose! The word was #{@word}."
          break
        end
      end
    end
  end

  private

  def display_word
    word.each_char do |char|
      if @guesses.include?(char.downcase)
        print char
      else
        print "_"
      end
      print " "
    end
    puts
  end

  def won?
    @word.chars.uniq.sort == @guesses.uniq.sort
  end

  def lost?
    @incorrect_guesses >= @max_guesses
  end

  attr_reader :word
end

word = "hangman"
game = Hangman.new(word)
game.play
