package main

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

var words = []string{
	"apple",
	"banana",
	"cherry",
	"date",
	"elderberry",
	"fig",
	"grape",
	"honeydew",
	"kiwi",
	"lemon",
}

func main() {
	rand.Seed(time.Now().UnixNano())

	// Pick a random word from the list
	word := words[rand.Intn(len(words))]
	guesses := make([]string, 0)
	misses := 0

	// Print the initial state
	fmt.Println("Welcome to Hangman!")
	fmt.Printf("The word has %d letters\n", len(word))
	fmt.Println(strings.Repeat("-", len(word)))

	// Keep playing until the player wins or loses
	for {
		// Get a guess from the player
		var guess string
		fmt.Print("Guess a letter: ")
		fmt.Scanln(&guess)

		// Check if the guess is valid
		if len(guess) != 1 || !isLetter(guess[0]) {
			fmt.Println("Invalid guess, please try again")
			continue
		}

		// Check if the guess is in the word
		if strings.Contains(word, guess) {
			fmt.Println("Correct!")
			guesses = append(guesses, guess)

			// Print the updated word with guessed letters filled in
			fmt.Println(wordWithGuesses(word, guesses))

			// Check if the player has won
			if hasWon(word, guesses) {
				fmt.Println("Congratulations, you win!")
				return
			}
		} else {
			fmt.Println("Incorrect!")
			misses++

			// Check if the player has lost
			if misses >= 6 {
				fmt.Println("Sorry, you lose.")
				fmt.Printf("The word was %s\n", word)
				return
			}
		}
	}
}

func isLetter(c byte) bool {
	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
}

func wordWithGuesses(word string, guesses []string) string {
	var result strings.Builder
	for i := 0; i < len(word); i++ {
		if contains(guesses, string(word[i])) {
			result.WriteByte(word[i])
		} else {
			result.WriteByte('-')
		}
	}
	return result.String()
}

func hasWon(word string, guesses []string) bool {
	for i := 0; i < len(word); i++ {
		if !contains(guesses, string(word[i])) {
			return false
		}
	}
	return true
}

func contains(arr []string, elem string) bool {
	for i := 0; i < len(arr); i++ {
		if arr[i] == elem {
			return true
		}
	}
	return false
}
