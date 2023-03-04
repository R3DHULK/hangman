# Set up the game
word_to_guess <- "hangman"
correct_guesses <- rep("_", nchar(word_to_guess))
incorrect_guesses <- c()
max_incorrect_guesses <- 6

# Define a function to display the current state of the game
display_game <- function() {
  cat(paste(correct_guesses, collapse=" "))
  cat("\n")
  cat("Incorrect guesses: ", paste(incorrect_guesses, collapse=", "))
  cat("\n\n")
}

# Define a function to check if the game has been won
game_won <- function() {
  return(all(correct_guesses != "_"))
}

# Define a function to check if the game has been lost
game_lost <- function() {
  return(length(incorrect_guesses) >= max_incorrect_guesses)
}

# Play the game
while(!game_won() && !game_lost()) {
  display_game()
  guess <- readline(prompt="Guess a letter: ")
  
  # Check if the guess is correct
  if(str_detect(word_to_guess, guess)) {
    correct_guesses[str_detect(word_to_guess, guess)] <- guess
  } else {
    incorrect_guesses <- c(incorrect_guesses, guess)
  }
}

# Display the final state of the game
display_game()

# Display the result
if(game_won()) {
  cat("You won!")
} else {
  cat("You lost. The word was ", word_to_guess, ".", sep="")
}
