#!/usr/bin/env perl

use warnings;
use strict;

#   Rock     Paper     Scissors
#     A        B          C
#     X        Y          Z
#     1        2          3

my %outcomes = (
    X => { 'C' => 2, 'B' => 1, 'A' => 3},
    Y => { 'C' => 6, 'B' => 5, 'A' => 4},
    Z => { 'C' => 7, 'B' => 9, 'A' => 8},
);

my $sum = 0;

while (<>) {
    my($abc, $xyz) = m/(\w) (\w)/;

    $sum += $outcomes{$xyz}{$abc};
}

print "$sum\n";
