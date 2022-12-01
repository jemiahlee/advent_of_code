#!/usr/bin/env perl

use warnings;
use strict;

undef $/;
$/ = "\n\n";

my @sums;

while(<>) {
    my $sum;
    push @sums, map {$sum += $_ if $_} split /\n/;
}

@sums = sort {$b <=> $a} @sums;
print "top 3: @sums[0..2]\n";

my $top_3_total = $sums[0] + $sums[1] + $sums[2];
print "total: $top_3_total\n";
