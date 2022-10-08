#! /usr/bin/perl
use warnings;
use strict;
use 5.010;
use Term::ANSIColor;

#Reads in the Dictionary file
#INPUT: NONE
#OUTPUT: NONE
#RETURNS: Reference to the Dictionary array
sub readInDictionary
{
	#Opens the dictionary file
	open FILE, "dict.txt" or die $!;
	#Saves the file to an array
	my @dict = <FILE>;
	#Returns a pointer to the array
	return \@dict;
}

#Chooses a random word from the dictionary file
#INPUT: Reference to the Dictionary Array
#OUTPUT: NONE
#RETURNS: Reference to the Chosen Word as an array.
sub chooseWord
{
	#Gets the dictionary array reference from pass in
	my $dict = shift;
	my @dict = @$dict;
	#Removes extra whitespace and uppercases the word.
	chomp(my $word = uc($dict[rand @dict]));
	#Splits the string to an array
	my @theWord = split('',$word);
	#Returns the reference of the array
	return \@theWord;
}

#Initalizes the fill in array, with underscores for the letters.  Returns the reference of the array.
#INPUT: Reference to the Word array
#OUTPUT: NONE
#RETURNS: Reference to the fill in array
sub initGuessArray
{
	#Initalize variables
	#Split the string into an array
	my $theWord = shift;
	my @theWord = @$theWord;
	#Make an array to fill in
	my @fillIn;
	#Counter to use to populate the fill-in array.  
	my $counter = 0;
	#For each character in the @theWord Array, fill the fillIn array with an _ if its a letter, otherwise fill it with the character.from the 
	foreach (@theWord)
	{
		#If its a letter populate an underscore
		if ($_ =~ /[a-zA-Z]/)
		{
			$fillIn[$counter] = "_";
		}
		#If its not a letter populate the character
		else
		{
			$fillIn[$counter] = $theWord[$counter];
		}
		#Increment the counter for the space in the arrays
		$counter++;
	}
	#Returns an array reference where the letters are represented by underscores.
	return \@fillIn;
}

#Checks each character in the Word array to see if the guess matched.  If it does populate the fillIn Array with the letter, if it does not populate the wrong letter array.
#INPUT: References to the word, fillin, and wrong letter arrays.  The letter which was guessed.
#OUTPUT: NONE
#RETURNS: NONE
sub checkLetter
{
	my $word = shift;
	my $fillIn = shift;
	my $wrongLetter = shift;
	my $letter = shift;
	my $counter = 0;
	my $wrongLetterCounter = 0;
	#Reference an array as @{$RefVariable}
	foreach (@$word)
	{
		if ($_ eq $letter)
		{
			@$fillIn[$counter] = $letter;
		}
		if ($_ ne $letter)
		{
			$wrongLetterCounter++;
#			push (@$wrongLetter, $letter);
		}
		$counter++;
	}
	if ($wrongLetterCounter == scalar @$word)
	{
		push (@$wrongLetter, $letter);
	}
}

#Prints the contents of an array so they appear as a word.
#INPUT: Array Reference to print Colorscheme to use for the characters.
#OUTPUT: Array in color specificed.
#RETURNS: NONE
sub printArray
{
	#Get in the array
	my $arrayRef = shift;
	my $colorScheme = shift;
	my $counter = 0;
	#Prints each letter
	foreach (@$arrayRef)
	{
		given ($colorScheme)
		{
			when(1)
			{
				if (@$arrayRef[$counter] eq '_')
				{	
					print colored ['red'], @$arrayRef[$counter];
				}
				else
				{
					print colored ['cyan'], @$arrayRef[$counter];
				}
				break;
			}
			when(2)
			{
				print colored ['yellow'], @$arrayRef[$counter];
				break;
			}
			when(3)
			{
				print colored ['red'], @$arrayRef[$counter];
				break;
			}
		}
		$counter++;
	}
}
#Draw the stages of Hangman
#INPUT: Numerical Stage to Draw
#OUTPUT: Hangman Stage
#RETURNS: NONE
sub drawHang
{
	my $turn = shift;
	given ($turn)
	{
                when(0)
                {
                        print colored ['bright_green'],"┌────────┐\n";
                        print colored ['bright_green'],"│        │\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'], "██████████\n";
                        print colored ['bright_blue'], "████████████\n";
                        print colored ['bright_blue'], "██████████████\n";
                        break;
                }
		when(1)
		{
			print colored ['bright_green'],"┌────────┐\n";
			print colored ['bright_green'],"│        │\n";
			print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
			print colored ['bright_green'], "│\n";
			print colored ['bright_green'], "│\n";
			print colored ['bright_green'], "│\n";
			print colored ['bright_green'], "│\n";
			print colored ['bright_blue'],  "██████████\n";
			print colored ['bright_blue'],  "████████████\n";
			print colored ['bright_blue'],  "██████████████\n";
			break;
		}
		when(2)
		{
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
			break;
		}
		when(3)
		{
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
                        print colored ['red'], "@\n";
                        print colored ['bright_green'], "│       ";
                        print colored ['red'], "/|\n";
                        print colored ['bright_green'], "│        ";
                        print colored ['red'], "|\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
			break;
		}
		when(4)
		{
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
                        print colored ['bright_green'], "│       ";
			print colored ['red'], "/|\\\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
			break;
		}
                when(5)
                {
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
                        print colored ['bright_green'], "│       ";
			print colored ['red'], "/|\\\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│       ";
			print colored ['red'], "/ \n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
                        break;
                }
                when(6)
                {
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
                        print colored ['bright_green'], "│       ";
			print colored ['red'], "/|\\\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│       ";
			print colored ['red'], "/ \\\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
                        break;
                }
                when(7)
                {
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
                        print colored ['bright_green'], "│      ";
			print colored ['red'], "_/|\\\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│       ";
			print colored ['red'], "/ \\\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
                        break;
                }
                when(8)
                {
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
                        print colored ['bright_green'], "│      ";
			print colored ['red'], "_/|\\_\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│       ";
			print colored ['red'], "/ \\\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
                        break;
                }
                when(9)
                {
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
                        print colored ['bright_green'], "│      ";
			print colored ['red'], "_/|\\_\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│      ";
			print colored ['red'], "_/ \\\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
                        break;
                }
                when(10)
                {
                        print colored ['bright_green'], "┌────────┐\n";
                        print colored ['bright_green'], "│        │\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "@\n";
                        print colored ['bright_green'], "│      ";
			print colored ['red'], "_/|\\_"."\n";
                        print colored ['bright_green'], "│        ";
			print colored ['red'], "|\n";
                        print colored ['bright_green'], "│      ";
			print colored ['red'], "_/ \\_"."\n";
                        print colored ['bright_green'], "│\n";
                        print colored ['bright_blue'],  "██████████\n";
                        print colored ['bright_blue'],  "████████████\n";
                        print colored ['bright_blue'],  "██████████████\n";
                        break;
                }
	}
}

#Takes in the command Line Input and verifies it is valid
#INPUT: Command Line (a single Character)
#OUTPUT: NONE
#RETURNS: A string of a single character
sub takeInputAndValidate
{
	#Initalize wrongLetter Array
	my $wrongLetter = shift;
	#Make a Hash of the letters
	my %wrongLetters = map {$_ => 1 } @$wrongLetter;
	#Initalize the letter with invalid content
	my $letter = "AAA112";
	#Create error Flag
	my $errorFlag = 0;
	#Take Input while the length of the letter is greater than 1, while it does not only contain letters, and if it has already been guessed.
	while (length $letter >1 || $letter =~ m/[^A-Z]/ || exists($wrongLetters{$letter}))
	{
		if ($errorFlag >0)
		{
			print "You entered a character, which is not a letter, or multiple letters.\n";
		}
		print "Please Enter a letter. \n##";
		#Take Input and Uppercase it.
		chomp($letter = uc(<STDIN>));
		$errorFlag++;
	}
	return $letter;
}

#This is the game logic.  It runs the whole hangman game.
#INPUT: the letter guessed, references to the word array, the fillin array, and the wrong letter array.
#OUTPUT: Win or Loose messages
#RETURNS: NONE
sub gameLogic
{
	#Initalizes variables
	my $letter = "";
	my $winFlag = 0;
	my $theWord = shift;
	my $fillIn = shift;
	my $wrongLetter = shift;
	my $wrongGuesses = 0;
	#Run the game through 10 errors.  The equivalant of head, body, arms, legs, hands, feet
	for (my $i = 0; $i < 11;)
	{
		system("clear");
		drawHang($i);
		print "\n";
		#Print FillIn Array
		printArray($fillIn,1);
		print "\n";
		#Print wrong letter array
		printArray($wrongLetter,2);
		print "\n";
		#Ask for Input
		$letter = takeInputAndValidate($wrongLetter);
		#Run Checkletter to check if its in the word
		checkLetter($theWord, $fillIn, $wrongLetter, $letter);
		#Make the counter equal to the length of the wrong letter array to count how many errors have been made.
		$i = scalar @$wrongLetter;
		#Make the arrays strings so they can be compared
		my $word = join ("",@$theWord);
		my $fillItIn = join ("",@$fillIn);
		#Compare the strings.  If they match Set win condition
		if ($word eq $fillItIn)
		{
			$winFlag = 1;
			last;
		}
	}
	#Print messages for win and loose conditions
	given ($winFlag)
	{
		when (0) 
		{
			print "You Loose!  The word was ";
			&printArray($theWord,3);
			print ".\n";
			break; 
		}
		when (1) 
		{
			print " You Win! The Word was "; 
			printArray($theWord, 2);
			print ".\n";
			break; 
		}
	}
	pressAKey();
	print "\n\n";
	return $winFlag;
}

#Wait until keypress to continue
#INPUT: keypress
#OUTPUT: NONE
#RETURNS: NONE
sub pressAKey
{
	print "Press a Key to Continue\n";
	my $waitForIt = <STDIN>;
}

#Displays a Title Page 
#INPUT: KEYPRESS via keypress subroutine
#OUTPUT: Title Page
#RETURNS: NONE
sub titlePage
{
	system("clear");
#Create a 80x60 character title screen
	print colored ['bright_blue'],"╔══════════════════════════════════════════════════════════════════════════════╗\n";
	print colored ['bright_blue'],"║									       ║\n";
	print colored ['bright_blue'],"║";
	print colored ['red'],        "      ██░ ██  ▄▄▄       ███▄    █   ▄████  ███▄ ▄███▓ ▄▄▄       ███▄    █     ";       
        print colored ['bright_blue'],"║\n║";
	print colored ['red'],        "     ▓██░ ██▒▒████▄     ██ ▀█   █  ██▒ ▀█▒▓██▒▀█▀ ██▒▒████▄     ██ ▀█   █     ";
        print colored ['bright_blue'],"║\n║";
	print colored ['red'],        "     ▒██▀▀██░▒██  ▀█▄  ▓██  ▀█ ██▒▒██░▄▄▄░▓██    ▓██░▒██  ▀█▄  ▓██  ▀█ ██▒    ";
        print colored ['bright_blue'],"║\n║";
	print colored ['red'],        "     ░▓█ ░██ ░██▄▄▄▄██ ▓██▒  ▐▌██▒░▓█  ██▓▒██    ▒██ ░██▄▄▄▄██ ▓██▒  ▐▌██▒    ";
        print colored ['bright_blue'],"║\n║";
	print colored ['red'],        "     ░▓█▒░██▓ ▓█   ▓██▒▒██░   ▓██░░▒▓███▀▒▒██▒   ░██▒ ▓█   ▓██▒▒██░   ▓██░    ";
        print colored ['bright_blue'],"║\n║";
	print colored ['red'],        "      ▒ ░░▒░▒ ▒▒   ▓▒█░░ ▒░   ▒ ▒  ░▒   ▒ ░ ▒░   ░  ░ ▒▒   ▓▒█░░ ▒░   ▒ ▒     ";
        print colored ['bright_blue'],"║\n║";
	print colored ['red'],        "      ▒ ░▒░ ░  ▒   ▒▒ ░░ ░░   ░ ▒░  ░   ░ ░  ░      ░  ▒   ▒▒ ░░ ░░   ░ ▒░    ";
        print colored ['bright_blue'],"║\n║";
	print colored ['red'],        "      ░  ░░ ░  ░   ▒      ░   ░ ░ ░ ░   ░ ░      ░     ░   ▒      ░   ░ ░     ";
        print colored ['bright_blue'],"║\n║";
	print colored ['red'],        "      ░  ░  ░      ░  ░         ░       ░        ░         ░  ░         ░     ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║                                                                              ║\n";
        print colored ['bright_blue'],"║                                                                              ║\n";
	print colored ['bright_blue'],"║";
        print colored ['bright_green'], "                                ┌────────┐                                    ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_green'], "                                │        │                                    ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_green'], "                                │        ";
        print colored ['red'], "@                                    ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_green'], "                                │      ";
        print colored ['red'], "_/|\\_                                  ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_green'], "                                │        ";
        print colored ['red'], "|                                    ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_green'], "                                │      ";
        print colored ['red'], "_/ \\_                                  ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_green'], "                                │                                             ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_blue'],  "                                ██████████                                    ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_blue'],  "                                ████████████                                  ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║";
        print colored ['bright_blue'],  "                                ██████████████                                ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║                                                                              ║\n";
        print colored ['bright_blue'],"║                                                                              ║\n";
        print colored ['bright_blue'],"║";
	print colored ['cyan'],"                              By: Sumalya Chatterjee                           ";
        print colored ['bright_blue'],"║\n";
        print colored ['bright_blue'],"║                                                                              ║\n";
	print colored ['bright_blue'],"║";
	print colored ['cyan'],"           github link ::  https://github.com/R3DHULK/hangman         ";
        print colored ['bright_blue'],"║\n";
	print colored ['bright_blue'],"║                                                                              ║\n";
        print colored ['bright_blue'],"╚══════════════════════════════════════════════════════════════════════════════╝\n";
	print "\n";
	pressAKey();
}

sub mainMenu
{
	my $gamesPlayed = 0;
	my $gamesWon = 0;
	for ($gamesPlayed = 0;; $gamesPlayed++)
	{
		if ($gamesPlayed > 0)
		{
			system("clear");
		        print colored ['green'],"#     #                    #     #\n";
        		print colored ['green'],"##   ##   ##   # #    #    ##   ## ###### #    # #    #\n";
		        print colored ['green'],"# # # #  #  #  # ##   #    # # # # #      ##   # #    #\n";
        		print colored ['green'],"#  #  # #    # # # #  #    #  #  # #####  # #  # #    #\n";
		        print colored ['green'],"#     # ###### # #  # #    #     # #      #  # # #    #\n";
        		print colored ['green'],"#     # #    # # #   ##    #     # #      #   ## #    #\n";
	        	print colored ['green'],"#     # #    # # #    #    #     # ###### #    #  ####\n";
	        	print "\n\n";
			my $errorFlag = 0;
			my $playGame ='asdf';
			while ($playGame =~ /[^Y|YES|N|NO]/ )
			{
				if ($errorFlag > 0)
				{
					print "Please Enter Y, YES, N, or NO\n";
				}
				print "Do you want to play a game of Hangman?\nEnter (Y)ES to play or (N)O to Quit.\n##";
				chomp ($playGame = uc(<STDIN>));
				$errorFlag++;
			}
			given ($playGame)
			{
				when ($playGame =~ /Y|YES/)
				{	
					$gamesWon = $gamesWon + mainRoutine();
					break;
				}
				when ($playGame =~ /N|NO/)
				{
					system("clear");
					print "Goodbye. Modified By R3DHULK\n";
					last;
				}
			}		
		}
		else
		{
			$gamesWon = $gamesWon + mainRoutine();
		}
	}
	print "You won $gamesWon games of $gamesPlayed games played.\n";
}

#This is the main function of the array.  It holds the main values of the arrays, and calls the main subroutines.  
#INPUT: NONE
#OUTPUT: NONE
#RETURNS: NONE
sub mainRoutine
{
	#Initialize the arrays
	my @wrongLetter = ();
	my @theWord = ();
	my @fillIn = ();
	my $theWord = chooseWord(readInDictionary());
	@theWord = @$theWord;
	my $fillIn = initGuessArray(\@theWord);
	@fillIn = @$fillIn;
	#Run the Game
	my $win = gameLogic(\@theWord, \@fillIn, \@wrongLetter);
	return $win;
}

sub main
{
	titlePage();
	mainMenu();
}

main();
