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

    my $tallest = 1;
    for my $tree (@{$data[$y]}[0..$x-1]){
        $tallest = 0 if $tree >= $height;
    }

    do {
        return 1;
    } if $tallest;

    $tallest = 1;
    for my $tree (@{$data[$y]}[$x+1..$#{$data[$y]}]){
        $tallest = 0 if $tree >= $height;
    }

    do {
        return 1;
    } if $tallest;

    $tallest = 1;
    for my $tree (map {$data[$_][$x]} 0..$y-1){
        $tallest = 0 if $tree >= $height;
    }

    do {
        return 1;
    } if $tallest;

    $tallest = 1;
    for my $tree (map {$data[$_][$x]} $y+1..$#data){
        $tallest = 0 if $tree >= $height;
    }

    do {
        return 1;
    } if $tallest;

}
