#!/usr/bin/env perl

use warnings;
use strict;

use Set::Scalar;

my $sum = 0;
while(<>){
    m{(\d+)-(\d+),(\d+)-(\d+)};

    my $set1 = Set::Scalar->new($1..$2);
    my $set2 = Set::Scalar->new($3..$4);

    $sum++ if $set1->intersection($set2) or $set2->intersection($set1);
}

print "$sum\n";
