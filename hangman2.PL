use strict;
use warnings;
use feature ":5.10";

# global variables
my @words = ("banana", "dog", "cat", "chair");
my @guesses = ();
my $solved = 0;
my $num_of_tries = 0;

&main(); # call the main method

sub main {

        # choose a random word
        my $word = @words [int(rand(3)) - 1];
        my $size = length($word);
        print"The word is: " . $word . "\n";
        for (my $i=0; $i < $size; $i++) {
                $guesses [$i] = '_';
        }
        while (!$solved) {
                &hangmanDisplay();

                print join(" ", @guesses);
                print "\n\nEnter a letter: ";
                my $guess = <>;
                chomp($guess); # remove newline
                
                &checkLetter($word, $guess);

                $solved = &checkWin($word);

                system $^O eq 'MSWin32' ? 'cls' : 'clear'; #clear the screen
        }

    print join(" ", @guesses);
    print "\n\nYay you win!\n";
}
sub hangmanDisplay() {
    given($num_of_tries) {
        when(0) {&hangman1Display();}
        when(1) {&hangman2Display();}
        when(2) {&hangman3Display();}
        when(3) {&hangman4Display();}
        when(4) {&hangman5Display();}
        when(5) {&hangman6Display();}
        when(6) {&hangman7Display();}
    }
}

sub checkLetter {
    my ($word, $guess) = @_;
    my $letterIndex = index($word, $guess);

    if ($letterIndex == -1) {
        print "Wrong!\n";
        $num_of_tries++;
    } else {
        for (my $i=0; $i < length($word); $i++) {
            my $c_letter = substr($word, $i, 1);
            if ($guess eq $guesses[$i]) {
                print "You already guessed $guess!\n";
            }
            if ($guess eq $c_letter) {
                $guesses [$i] = $c_letter;
            }
        }
    }
}
sub checkWin {
    my ($word) = @_;
    my $letter;
    for (my $i=0; $i< length($word); $i++) {
        $letter = substr($word, $i, 1);
        if ($letter ne $guesses [$i]) {
            return 0;
        }
    }
    return 1;
}
sub hangman1Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman2Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman3Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |     |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman4Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman5Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|/\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman6Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|/\n";
        print "  |     /\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
}

sub hangman7Display
{
        print "  -------\n";
        print "  |     |\n";
        print "  |     x\n";
        print "  |    \\|/\n";
        print "  |     /\\\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
    print "You lost!\n";
    exit 0;
}
