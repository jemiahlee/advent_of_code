#!/usr/bin/env perl

use warnings;
use strict;

my $input;
my $line_length;

while(<>) {
    chomp;
    $line_length ||= length($_) + 2;
    $input .= '.' . $_ . '.';
}

my %structure;

my $sum = 0;

while($input =~ /(\d+)/g) {
    my $start = $-[0] > 0 ? $-[0]-1 : $-[0];
    my $end = $+[0] < $line_length ? $+[0]+1 : $+[0];
    for(my $i = $start; $i <= $end; $i++) {
        push @{$structure{$i}}, {number => $1, range => [$start..$end]};
    }
}

while($input =~ m/[*]/g) {
    my $index = $-[0];

    my @gear_ratios;

    if($structure{$index-$line_length}) {
        push @gear_ratios, find_numbers_near_index($index-$line_length);
    }

    push @gear_ratios, find_numbers_near_index($index);

    if($structure{$index+$line_length}) {
        push @gear_ratios, find_numbers_near_index($index+$line_length);
    }

    if(scalar(@gear_ratios) == 2) {
        my $product = $gear_ratios[0] * $gear_ratios[1];
        $sum += $product;
    }
}

print "$sum\n";

sub find_numbers_near_index {
    my $index = shift;

    my @values;

    foreach my $hash (@{$structure{$index}}) {
        push @values, $hash->{number};
    }

    return @values;
}
