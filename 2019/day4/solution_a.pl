#!/usr/bin/perl

use strict;
use warnings;

my $lower_bound = shift;
my $upper_bound = shift;

my $count = 0;

NUMBER:
while( $lower_bound <= $upper_bound ) {
    next NUMBER unless $lower_bound =~ /(\d)\1/;
    # my $dupes = 0;

    my @nums = split //, $lower_bound;
    for(my $i = 1; $i < @nums; $i++) {
        next NUMBER if $nums[$i-1] > $nums[$i];
        # $dupes = 1 if $nums[$i-1] == $nums[$i];
    }

    $count++;
    # $count++ if $dupes;
} continue {
    $lower_bound++;
}

print "$count numbers match.\n";
