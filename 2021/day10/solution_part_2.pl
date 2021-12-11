#!/usr/bin/env perl

use warnings;
use strict;

my %scores = (
    '(' => 1,
    '[' => 2,
    '{' => 3,
    '<' => 4,
);

my %matches = (
    '{' => '}',
    '(' => ')',
    '[' => ']',
    '<' => '>',
);

LINE:
while(<>){
    chomp;

    my @stack;
    foreach my $i (split //){
        if($matches{$i}){
            unshift(@stack, $i);
        }
        elsif(@stack and $matches{$stack[0]} eq $i){
            shift(@stack);
        }
        elsif(@stack and not defined($matches{$i})){
            next LINE;
        }
    }

    if(@stack){
        print score(\@stack), "\n";
        next LINE;
    }
}


sub score {
    my $arr = shift;

    my $score = 0;
    for my $bracket (@$arr){
        $score = $score * 5 + $scores{$bracket};
    }

    return $score;
}
