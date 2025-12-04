#!/usr/bin/perl

use warnings;
use strict;

my $sum = 0;

while(<>){
    chomp;

    my $joltage = find_joltage($_);

    $sum += $joltage;
    print "Adding $joltage to the collective joltage\n";
}

print "Answer is $sum\n";

sub find_joltage {
    my $input = shift;

    for(my $i = 99; $i > 0; $i--) {
        my($first, $second) = split //, sprintf("%02d", $i);

        return $i if $input =~ /$first\d*?$second/;
    }
}
