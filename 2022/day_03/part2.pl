#!/usr/bin/env perl

use warnings;
use strict;

my %letters = (
    'a' => 1,
    'b' => 2,
    'c' => 3,
    'd' => 4,
    'e' => 5,
    'f' => 6,
    'g' => 7,
    'h' => 8,
    'i' => 9,
    'j' => 10,
    'k' => 11,
    'l' => 12,
    'm' => 13,
    'n' => 14,
    'o' => 15,
    'p' => 16,
    'q' => 17,
    'r' => 18,
    's' => 19,
    't' => 20,
    'u' => 21,
    'v' => 22,
    'w' => 23,
    'x' => 24,
    'y' => 25,
    'z' => 26,
    'A' => 27,
    'B' => 28,
    'C' => 29,
    'D' => 30,
    'E' => 31,
    'F' => 32,
    'G' => 33,
    'H' => 34,
    'I' => 35,
    'J' => 36,
    'K' => 37,
    'L' => 38,
    'M' => 39,
    'N' => 40,
    'O' => 41,
    'P' => 42,
    'Q' => 43,
    'R' => 44,
    'S' => 45,
    'T' => 46,
    'U' => 47,
    'V' => 48,
    'W' => 49,
    'X' => 50,
    'Y' => 51,
    'Z' => 52,
);

my $sum = 0;
my @buffer;

while(<>) {
    chomp;

    push(@buffer, $_);
    if(scalar(@buffer) == 3) {
        $sum += $letters{find_diff(@buffer)};
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
