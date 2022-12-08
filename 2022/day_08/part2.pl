#!/usr/bin/env perl

use warnings;
use strict;

my @data;

while(<>) {
    chomp;

    push @data, [split(//)];
}

my $best_scenic_score = -1;
for my $y (0..$#data){
    for my $x (0..$#{$data[$y]}) {
        my $scenic_score = score_tree($x, $y);

        $best_scenic_score = $scenic_score if $scenic_score > $best_scenic_score;
        print "Scenic score is $scenic_score for [$x,$y]\n";
    }
}

print "Best scenic score: $best_scenic_score\n";

sub score_tree {
    my($x, $y) = @_;

    if($y == 0 or $y == $#data or $x == 0 or $x == $#{$data[$y]}){
        return 0;
    }

    my $height = $data[$y][$x];

    my $top = 0;
    for my $tree (reverse @{$data[$y]}[0..$x-1]){
        $top++;
        print "Adding one to top ($tree)\n" if $x == 2 && $y == 3;
        last if $tree >= $height;
    }

    my $bottom = 0;
    for my $tree (@{$data[$y]}[$x+1..$#{$data[$y]}]){
        $bottom++;
        print "Adding one to bottom ($tree)\n" if $x == 2 && $y == 3;
        last if $tree >= $height;
    }

    my $left = 0;
    for my $tree (reverse map {$data[$_][$x]} 0..$y-1){
        print "Adding one to left ($tree)\n" if $x == 2 && $y == 3;
        $left++;
        last if $tree >= $height;
    }

    my $right = 0;
    for my $tree (map {$data[$_][$x]} $y+1..$#data){
        print "Adding one to right ($tree)\n" if $x == 2 && $y == 3;
        $right++;
        last if $tree >= $height;
    }

    return $top * $bottom * $right * $left;
}
