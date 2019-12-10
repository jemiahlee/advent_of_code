#!/usr/bin/perl

use strict;
use warnings;

my $total = 0;

while( <> ) {
    chomp;

    my $fuel = compute_fuel($_);
    $total += $fuel;
}

print "Total fuel used: $total\n";

sub compute_fuel {
    my $input = shift;
    return 0 if $input <= 0;

    my $marginal_fuel = int($input / 3) - 2;

    return 0 if $marginal_fuel <= 0;
    return $marginal_fuel + compute_fuel($marginal_fuel);
}
