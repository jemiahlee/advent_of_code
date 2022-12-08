#!/usr/bin/env perl

use warnings;
use strict;

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

    if($y == 0 or $y == $#data or $x == 0 or $x == $#{$data[$y]}){
        return 1;
    }

    my $height = $data[$y][$x];

    return 1 if is_tallest($height, @{$data[$y]}[0..$x-1]);
    return 1 if is_tallest($height, @{$data[$y]}[$x+1..$#{$data[$y]}]);
    return 1 if is_tallest($height, map {$data[$_][$x]} 0..$y-1);
    return 1 if is_tallest($height, map {$data[$_][$x]} $y+1..$#data);
}

sub is_tallest {
    my $height = shift;
    my @other_trees = @_;

    for my $tree (@other_trees) {
        return 0 if $tree >= $height;
    }

    return 1;
}
