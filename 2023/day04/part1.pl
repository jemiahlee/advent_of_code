#!/usr/bin/env perl

use warnings;
use strict;

my $total_points = 0;

while(<>) {
    chomp;
    die unless /Card\s+(\d+):\s*((?:\d+\s*)+)\|\s*((?:\d+\s*)+)/;
    my($card_number, $winning_numbers, $our_numbers) = ($1, $2, $3);

    my @winning_numbers = split /\s+/, $winning_numbers;
    my $winning_number_count = 0;
    foreach my $winning_number (@winning_numbers) {
        do { print "Winning number: $winning_number\n"; $winning_number_count++ } if $our_numbers =~ /\b$winning_number\b/;
    }

    my($score) = $winning_number_count == 0 ? 0 : 2 ** ($winning_number_count-1);
    print "Card $card_number winning number count: $winning_number_count, score: $score\n";
    $total_points += $score;
}

print "Total score: $total_points\n";
