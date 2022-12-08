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

        do {
            $best_scenic_score = $scenic_score;
            print "Scenic score is $scenic_score for [$x,$y]\n";
        } if $scenic_score > $best_scenic_score;
    }
}

print "Best scenic score: $best_scenic_score\n";

sub score_tree {
    my($x, $y) = @_;

    if($y == 0 or $y == $#data or $x == 0 or $x == $#{$data[$y]}){
        return 0;
    }

    my $height = $data[$y][$x];

    return
        score_distance($height, reverse @{$data[$y]}[0..$x-1]) *
        score_distance($height, @{$data[$y]}[$x+1..$#{$data[$y]}]) *
        score_distance($height, reverse map {$data[$_][$x]} 0..$y-1) *
        score_distance($height, map {$data[$_][$x]} $y+1..$#data);
}

sub score_distance {
    my $height = shift;
    my @other_trees = @_;

    my $score = 0;
    for my $other_tree (@other_trees){
        $score++;
        last if $height <= $other_tree;
    }

    return $score;
}
