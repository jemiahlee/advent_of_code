#!/usr/bin/env perl

use warnings;
use strict;

use Set::Scalar;

my $length = 14;

while(<>) {
    chomp;

    for my $index (0..(length() - $length)) {
        my $substring = substr($_, $index, $length);
        my $set = Set::Scalar->new(split //, $substring);

        do {
            print $substring, ': ', $index+$length, "\n";
            last;
        } if $set->size == $length;
    }
}
