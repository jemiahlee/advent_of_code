#!/usr/bin/env perl

use warnings;
use strict;

use List::Util qw/all/;

my @data;

while(<>) {
    chomp;

    push @data, [split(//)];
}

my $seen = 0;
for my $y (0..$#data){
    for my $x (0..$#{$data[$y]}) {
        $seen++ if is_visible($x, $y);
    }
}

print "Number seen: $seen\n";

sub is_visible {
    my($x, $y) = @_;

    my $height = $data[$y][$x];

    return 1 if all {$height > $_} @{$data[$y]}[0..$x-1];
    return 1 if all {$height > $_} @{$data[$y]}[$x+1..$#{$data[$y]}];
    return 1 if all {$height > $_} map {$data[$_][$x]} 0..$y-1;
    return 1 if all {$height > $_} map {$data[$_][$x]} $y+1..$#data;
}
