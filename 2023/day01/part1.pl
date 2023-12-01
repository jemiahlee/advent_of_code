#!/usr/bin/env perl

use warnings;
use strict;

my $sum = 0;

while(<>){
    m{\D*(\d)};
    my $first = $1;

    m{.*(\d)};
    my $second = $1;

    my $number = $first . $second;
    $sum += $number;

    print "line $.: $number\n";
}

print $sum, "\n";
