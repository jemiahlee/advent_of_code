#!/usr/bin/env perl

use warnings;
use strict;

sub ordinal {
    my $letter = shift;

    my $ordinal = ord($letter);
    if($ordinal > 90) {
        return $ordinal - 96;
    }
    return $ordinal - 38;
}

my $sum = 0;

while(<>) {
    chomp;

    my $length = length;
    my $half1 = substr($_, 0, $length/2);
    my $half2 = substr($_, $length/2, $length/2);

    die if length($half1) != length($half2);
    $sum += ordinal(find_diff($half1, $half2));

}

print $sum, "\n";

sub find_diff {
    my($half1, $half2) = @_;

    my %hash1;
    my %hash2;
    for my $letter (split //, $half1) {
        $hash1{$letter} = 1;
    }
    for my $letter (split //, $half2) {
        $hash2{$letter} = 1;
    }

    foreach my $key (keys %hash1) {
        return $key if $hash1{$key} and $hash2{$key};
    }
}
