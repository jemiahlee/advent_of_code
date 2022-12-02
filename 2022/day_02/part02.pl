#!/usr/bin/env perl

use warnings;
use strict;

#   Rock     Paper     Scissors
#     A        B          C
#     X        Y          Z
#     1        2          3

my %outcomes = (
    X => { 'C' => 'Y', 'B' => 'X', 'A' => 'Z'},
    Y => { 'C' => 'Z', 'B' => 'Y', 'A' => 'X'},
    Z => { 'C' => 'X', 'B' => 'Z', 'A' => 'Y'},
);

my %scores = (
    X => 1,
    Y => 2,
    Z => 3,
);

my %outcome_scores = (
    X => 0,
    Y => 3,
    Z => 6,
);

my $sum = 0;

while (<>) {
    my($abc, $xyz) = m/(\w) (\w)/;

    $sum += $outcome_scores{$xyz};
    $sum += $scores{$outcomes{$xyz}{$abc}};
}

print "$sum\n";
