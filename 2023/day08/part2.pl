#!/usr/bin/env perl

use warnings;
use strict;

use List::Util qw/all uniq/;

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

my @next_nodes = sort grep /..A/, keys(%map);

WALKING:
while ('true') {
    if($instructions[$step_count % $instruction_count] eq 'L') {
        traverse('left');
    }
    else {
        traverse('right');
    }

    $step_count++;
    # map { print "Step $step_count: $_\n" } @next_nodes;

    last if all {/..Z/} @next_nodes;
    @next_nodes = uniq @next_nodes;
}

print "Total steps: $step_count\n";


### END OF MAIN ###

sub traverse {
    my $direction = shift;

    for(my $i = 0; $i < scalar(@next_nodes); $i++) {
        $next_nodes[$i] = $map{$next_nodes[$i]}{$direction};
    }
}
