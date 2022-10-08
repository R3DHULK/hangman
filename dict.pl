#! /usr/bin/perl
use warnings;
use strict;

sub readInDictionary
{
	#Opens the dictionary file
	open FILE, "dict.new" or die $!;
	#Saves the file to an array
	my @dict = <FILE>;
	#Returns a pointer to the array
	return \@dict;
}

sub getWords
{
	my $words = shift;
	my @keep;
	foreach (@$words)
	{
		if (length $_ > 5)
		{
			push (@keep, $_);
		}
	}
	return \@keep;
}

sub writeToFile
{
	my $InputArray = shift;
	open FILE, ">> dict.txt";
	print FILE @$InputArray;
	close(FILE);
}

sub main
{
	my $dictionary = readInDictionary();
	my @dict = @$dictionary;
	my $dictionary1 = getWords($dictionary);
	print $dictionary1."\n";
	my @dict1 = @$dictionary1;
	writeToFile($dictionary1);
}

main ();
