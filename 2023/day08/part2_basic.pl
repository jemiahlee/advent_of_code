#!/usr/bin/env perl

use warnings;
use strict;

use List::Util qw/all/;

my(@factors) = (21409, 18157, 15989, 14363, 11653, 12737);
my $steps = 100_000_000_000_000;

while('true') {
    last if divisible_by_all($steps);
    $steps++;
}

print "Total steps: $steps\n";

sub divisible_by_all {
    my $number = shift;

    return all {$number % $_ == 0} @factors;
}

