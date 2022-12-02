#!/usr/bin/env perl

use warnings;
use strict;

#   Rock     Paper     Scissors
#     A        B          C
#     X        Y          Z
#     1        2          3

my %beats = (
    X => 'C',
    Y => 'A',
    Z => 'B',
);

my %ties = (
    X => 'A',
    Y => 'B',
    Z => 'C',
);

my %scores = (
    X => 1,
    Y => 2,
    Z => 3,
);

my $sum = 0;

while (<>) {
    my($abc, $xyz) = m/(\w) (\w)/;

    $sum += $scores{$xyz};

    if ($beats{$xyz} eq $abc) {
        $sum += 6;
    }
    elsif ($ties{$xyz} eq $abc) {
        $sum += 3;
    }
}

print "$sum\n";
