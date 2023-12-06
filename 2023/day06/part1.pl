#!/usr/bin/env perl

use warnings;
use strict;

undef $/;

my $line = <>;
$line =~ /Time:\s*((?:\s*\d+)+).*?Distance:\s*((?:\s*\d+)+)/s;

my @times = split /\s+/, $1;
my @distances = split /\s+/, $2;

my @total_wins;

foreach (my $i = 0; $i < @times; $i++) {

    my $race_wins = 0;
    foreach my $acceleration_time (1..($times[$i]-1)) {
        my $movement_time = $times[$i] - $acceleration_time;
        if($distances[$i] < $acceleration_time * $movement_time) {
            $race_wins++;
        }
    }

    push @total_wins, $race_wins;
}

my $total_wins = 1;
map {$total_wins *= $_} @total_wins;
print "Total wins: $total_wins\n";
