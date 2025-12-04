#!/usr/bin/perl

use warnings;
use strict;

my $sum = 0;

while(<>){
    chomp;

    my $joltage = find_joltage($_, 12);

    $sum += $joltage;
    print "Adding $joltage to the collective joltage\n";
}

print "Answer is $sum\n";

sub find_joltage {
    my $input = shift;
    my $length = shift;

    my $answer = '';

    for(my $i = $length; $i > 0; $i--) {
        my($number, $index);
        ($number, $input) = find_largest_leftmost($input, $i);

        $answer .= $number;
    }

    return $answer;
}

sub find_largest_leftmost {
    my $input = shift;
    my $length = shift;

    my $inverted_length = length($input) - $length;

    my @numbers = qw/9 8 7 6 5 4 3 2 1 0/;
    my $index = -1;

    foreach my $number (@numbers) {
        $index = index($input, $number);

        return ($number, substr($input, $index+1)) if $index >= 0 and $index <= $inverted_length;
    }
}
