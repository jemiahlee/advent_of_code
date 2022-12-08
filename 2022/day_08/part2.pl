#!/usr/bin/env perl

use warnings;
use strict;

use List::Util qw/product sum/;
use List::MoreUtils qw/before_incl/;

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

    # my previous solution was probably more readable, but this is clever
    # basically this just walks the four directions, scoring them as greater than current, or not.
    # then, the before_incl stops walking them once the block is not true (ie, hit a false value)
    # since we still *see* the one that is as tall or taller, ++ works here.
    my($top, $bottom, $left, $right);
    $left++ for before_incl {not $_} map {$height > $_} reverse @{$data[$y]}[0..$x-1];
    $right++ for before_incl {not $_} map {$height > $_} @{$data[$y]}[$x+1..$#{$data[$y]}];
    $top++ for before_incl {not $_} map {$height > $_} reverse map {$data[$_][$x]} 0..$y-1;
    $bottom++ for before_incl {not $_} map {$height > $_} map {$data[$_][$x]} $y+1..$#data;

    return product($top, $bottom, $left, $right);
}
