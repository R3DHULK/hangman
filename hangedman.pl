#!/usr/bin/perl

use strict;
use warnings;

# List of words to choose from
my @words = ("apple", "banana", "cherry", "date", "elderberry");

# Select a random word from the list
my $word = $words[int(rand(scalar @words))];
my @word_letters = split('', $word);

# Initialize the guessed letters to underscores
my @guessed_letters = map { '_' } @word_letters;

# Set up the number of guesses allowed and initialize the wrong guesses count
my $guesses_allowed = 6;
my $wrong_guesses = 0;

# Main game loop
while (1) {
    # Print the current state of the game
    print "\n\n\n";
    print "====================================\n";
    print "Hangman\n";
    print "Guesses remaining: " . ($guesses_allowed - $wrong_guesses) . "\n";
    print "Word: " . join(' ', @guessed_letters) . "\n";
    print "Enter a letter: ";

    # Get user input
    my $input = lc(<STDIN>);
    chomp($input);

    # Check if the input is a single letter
    if ($input !~ /^[a-z]$/i) {
        print "Please enter a single letter.\n";
        next;
    }

    # Check if the letter has already been guessed
    if (grep { $_ eq $input } @guessed_letters) {
        print "You've already guessed that letter.\n";
        next;
    }

    # Check if the letter is in the word
    my $found = 0;
    for (my $i = 0; $i < scalar @word_letters; $i++) {
        if ($word_letters[$i] eq $input) {
            $guessed_letters[$i] = $input;
            $found = 1;
        }
    }

    # Increment the wrong guesses count if the letter was not found in the word
    $wrong_guesses++ unless $found;

    # Check for win or loss
    if (!grep { $_ eq '_' } @guessed_letters) {
        print "\n\n\n";
        print "====================================\n";
        print "Hangman\n";
        print "Word: " . join(' ', @guessed_letters) . "\n";
        print "Congratulations, you win!\n";
        last;
    } elsif ($wrong_guesses == $guesses_allowed) {
        print "\n\n\n";
        print "====================================\n";
        print "Hangman\n";
        print "Word: " . join(' ', @word_letters) . "\n";
        print "Sorry, you lose. The word was \"$word\".\n";
        last;
    }
}
