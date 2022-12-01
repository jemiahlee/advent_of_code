#!/usr/bin/env perl

use warnings;
use strict;

undef $/;
$/ = "\n\n";

my $highest = -1;

while(<>) {
    my $sum;
    map {$sum += $_ if $_} split /\n/;

    $highest = $sum if $sum > $highest;
}

print $highest, "\n";
