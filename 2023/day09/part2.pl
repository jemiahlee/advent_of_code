#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw/all/;

my $sum = 0;
while(<>) {
    chomp;

    my @values = split /\s+/;
    $sum += compute_next_value(@values);
}

print "Total: $sum\n";


sub compute_next_value {
    my @initial_values = @_;

    my @pyramid;
    push @pyramid, [@initial_values];

    # build the pyramid
    while(not all {$_ == 0} @{$pyramid[-1]}) {
        my @next_row;

        for(my $i = 1; $i < scalar(@{$pyramid[-1]}); $i++) {
            push @next_row, ($pyramid[-1][$i] - $pyramid[-1][$i-1]);
        }

        push @pyramid, \@next_row;
    }

    # add extra values to the beginning
    for(my $i = (scalar(@pyramid)-2); $i >= 0; $i--) {
        unshift @{$pyramid[$i]}, ($pyramid[$i][0] - $pyramid[$i+1][0]);
    }

    return $pyramid[0][0];
}
