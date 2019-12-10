#!/usr/bin/perl

use strict;
use warnings;

my $lower_bound = shift;
my $upper_bound = shift;

my $count = 0;

NUMBER:
while( $lower_bound <= $upper_bound ) {
    next NUMBER unless $lower_bound =~ m{(?<!0)0{2}(?!0)|(?<!1)1{2}(?!1)|(?<!2)2{2}(?!2)|(?<!3)3{2}(?!3)|(?<!4)4{2}(?!4)|(?<!5)5{2}(?!5)|(?<!6)6{2}(?!6)|(?<!7)7{2}(?!7)|(?<!8)8{2}(?!8)|(?<!9)9{2}(?!9)};

    my @nums = split //, $lower_bound;
    for(my $i = 1; $i < @nums; $i++) {
        next NUMBER if $nums[$i-1] > $nums[$i];
    }

    $count++;
} continue {
    $lower_bound++;
}

print "$count numbers match.\n";
