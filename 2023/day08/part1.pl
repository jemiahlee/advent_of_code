#!/usr/bin/env perl

use warnings;
use strict;

my $instructions = <>;
chomp $instructions;

my %map;
while(<>) {
    next if /^\s*$/;

    die unless /^(\w{3})\s*=\s*\((\w{3}),\s*(\w{3})\)/;
    my($start, $left, $right) = ($1, $2, $3);

    $map{$start} = {left => $left, right => $right};
}

my $next_node = 'AAA';
my $FINAL_NODE = 'ZZZ';
my $step_count = 0;

my @instructions = split //, $instructions;
my $instruction_count = scalar(@instructions);

WALKING:
while ('true') {
    if($next_node eq 'ZZZ') {
        last WALKING;
    }

    if($instructions[$step_count % $instruction_count] eq 'L') {
        print "Going left ($instructions) at $next_node\n";
        $next_node = $map{$next_node}{left};
    }
    else {
        print "Going right ($instructions) at $next_node\n";
        $next_node = $map{$next_node}{right};
    }
    $step_count++;
}

print "Total steps: $step_count\n";
