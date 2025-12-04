#!/usr/bin/env perl

use warnings;
use strict;

my @codes;

while(<>) {
    chomp;
    push @codes, split /,/;
}

my $sum = 0;
foreach my $code (@codes) {
    my $computed_code = 0;
    foreach my $char (split //, $code) {
        $computed_code += ord($char);
        print "ord: $computed_code\n";

        $computed_code *= 17;
        print "* 17: $computed_code\n";

        $computed_code = $computed_code % 256;
        print "modulo 256: $computed_code\n";
    }
    $sum += $computed_code;
}

print "Sum was $sum\n";
