#!/usr/bin/env perl

use warnings;
use strict;

my %openers = (
    '(' => 1,
    '{' => 1,
    '[' => 1,
    '<' => 1,
);

my %matches = (
    '{' => '}',
    '(' => ')',
    '[' => ']',
    '<' => '>',
);

my %points = (
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
);

my $total_sum = 0;
my $clean_line_count = 0;

LINE:
while(<>){
    chomp;

    print "Processing line: $_\n";

    my @stack;
    foreach my $i (split //){
        print "Processing $i\n" if $verbose;
        if($openers{$i}){
            push(@stack, $i);
        }
        elsif(@stack and $matches{$stack[-1]} eq $i){
            pop(@stack);
        }
        elsif(@stack and not defined($openers{$i})){
            $total_sum += $points{$i};
            next LINE;
        }
        else {
            # nothing here yet, this is the incomplete case.
        }
    }

    $clean_line_count++;
}

print "Total sum was $total_sum\n";
print "# of clean lines: $clean_line_count\n";
