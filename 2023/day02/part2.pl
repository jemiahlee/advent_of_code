#!/usr/bin/env perl

use warnings;
use strict;

my $sum;

while(<>) {
    die unless m{Game (\d+):\s*(.*)};

    my $game_number = $1;
    my $game_power = game_power($2);

    $sum += $game_power;
    print "Power of Game #$game_number is $game_power.\n";
}

print "$sum\n";


sub game_power {
    my $game_data = shift;

    my @pulls = split /\s*;\s*/, $game_data;

    my %minimum_balls = (
        blue  => 0,
        green => 0,
        red   => 0,
    );

    foreach my $pull (@pulls) {
        while($pull =~ m{(\d+) (\w+)}g) {
            $minimum_balls{$2} = $1 if $1 > $minimum_balls{$2};
        }
    }

    my $product = 1;
    map {$product *= $minimum_balls{$_}} keys %minimum_balls;
    return $product;
}
