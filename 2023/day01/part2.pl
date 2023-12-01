#!/usr/bin/env perl

use warnings;
use strict;

my $sum = 0;
my $numbers = qr{one|two|three|four|five|six|seven|eight|nine};

my %lookup = (
    one => 1,
    two => 2,
    three => 3,
    four => 4,
    five => 5,
    six => 6,
    seven => 7,
    eight => 8,
    nine => 9,
);

while(<>){
    m{($numbers|\d)};
    my $first = $lookup{$1} || $1;

    m{.*($numbers|\d)};
    my $second = $lookup{$1} || $1;

    my $number = $first . $second;
    $sum += $number;

    print "line $.: $number\n";
}

print $sum, "\n";
