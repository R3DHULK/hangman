# Define a function to randomly select a word from a list
select_word <- function(word_list) {
  word_list[sample(length(word_list), 1)]
}

# Define a function to hide the word with underscores
hide_word <- function(word) {
  gsub(".", "_", word)
}

# Define a function to check if a letter is in the word
letter_in_word <- function(letter, word) {
  letter %in% strsplit(word, "")[[1]]
}

# Define the list of words to choose from
word_list <- c("banana", "apple", "orange", "peach", "pear")

# Select a random word from the list
word <- select_word(word_list)

# Hide the word with underscores
hidden_word <- hide_word(word)

# Define the maximum number of incorrect guesses
max_guesses <- 6

# Define the list of guessed letters
guessed_letters <- c()

# Start the game loop
while (max_guesses > 0) {
  
  # Display the hidden word and the guessed letters
  cat("Word:", hidden_word, "\n")
  cat("Guessed letters:", sort(guessed_letters), "\n")
  
  # Prompt the user for a guess
  guess <- readline(prompt = "Enter a letter: ")
  
  # Check if the guess is valid
  if (nchar(guess) != 1 || !grepl("[[:alpha:]]", guess)) {
    cat("Invalid guess. Please enter a single letter.\n")
    next
  }
  
  # Check if the guess has already been made
  if (guess %in% guessed_letters) {
    cat("You already guessed that letter. Please try again.\n")
    next
  }
  
  # Add the guess to the list of guessed letters
  guessed_letters <- c(guessed_letters, guess)
  
  # Check if the guess is in the word
  if (letter_in_word(guess, word)) {
    cat("Good guess!\n")
    hidden_word <- gsub(sprintf("[^%s]", guess), "_", word)
    if (hidden_word == word) {
      cat("Congratulations! You guessed the word!\n")
      break
    }
  } else {
    cat("Sorry, that letter is not in the word.\n")
    max_guesses <- max_guesses - 1
    if (max_guesses == 0) {
      cat("You ran out of guesses. The word was:", word, "\n")
      break
    }
  }
  
}

# End the game
cat("Thanks for playing!\n")
