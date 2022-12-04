#!/usr/bin/env perl

use warnings;
use strict;

my $sum = 0;
while(<>){
    m{(\d+)-(\d+),(\d+)-(\d+)};
    if(($1 >= $3 && $2 <= $4) || ($3 >= $1 && $4 <= $2)) {
        $sum++;
    }
}

print "$sum\n";
