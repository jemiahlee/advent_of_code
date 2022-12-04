#!/usr/bin/env perl

use warnings;
use strict;

use Set::Scalar;

my $sum = 0;
while(<>){
    m{(\d+)-(\d+),(\d+)-(\d+)};

    my $set1 = Set::Scalar->new($1..$2);
    my $set2 = Set::Scalar->new($3..$4);

    $sum++ if not $set1->difference($set2) or not $set2->difference($set1);
}

print "$sum\n";
