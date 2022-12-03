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
my @buffer;

while(<>) {
    chomp;

    push(@buffer, $_);
    if(scalar(@buffer) == 3) {
        $sum += ordinal(find_diff(@buffer));
        undef @buffer;
    }
}

print $sum, "\n";

sub find_diff {
    my($half1, $half2, $half3) = @_;

    my %hash1;
    my %hash2;
    my %hash3;
    for my $letter (split //, $half1) {
        $hash1{$letter} = 1;
    }
    for my $letter (split //, $half2) {
        $hash2{$letter} = 1;
    }
    for my $letter (split //, $half3) {
        $hash3{$letter} = 1;
    }

    foreach my $key (keys %hash1) {
        return $key if $hash1{$key} and $hash2{$key} and $hash3{$key};
    }
}
