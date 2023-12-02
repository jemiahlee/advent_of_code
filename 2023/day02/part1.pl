#!/usr/bin/env perl

use warnings;
use strict;

my %CUBES = (
    blue => 14,
    green => 13,
    red => 12,
);

my $sum;

while(<>) {
    die unless m{Game (\d+):\s*(.*)};

    my $game_number = $1;
    my $is_valid_game = is_valid_game($2);

    $sum += $game_number if $is_valid_game;
    print "Game #$game_number is ", ($is_valid_game ? '' : 'not '), "valid.\n";
}

print "$sum\n";


sub is_valid_game {
    my $game_data = shift;

    my @pulls = split /\s*;\s*/, $game_data;

    foreach my $pull (@pulls) {
        while($pull =~ m{(\d+) (\w+)}g) {
            return 0 if $1 > $CUBES{$2};
        }
    }

    return 1;
}
