#!/usr/bin/env perl

use warnings;
use strict;

my @sample_data = (
    [qw/Z N/],
    [qw/M C D/],
    [qw/P/],
);

#     [W]         [J]     [J]
#     [V]     [F] [F] [S] [S]
#     [S] [M] [R] [W] [M] [C]
#     [M] [G] [W] [S] [F] [G]     [C]
# [W] [P] [S] [M] [H] [N] [F]     [L]
# [R] [H] [T] [D] [L] [D] [D] [B] [W]
# [T] [C] [L] [H] [Q] [J] [B] [T] [N]
# [G] [G] [C] [J] [P] [P] [Z] [R] [H]
#  1   2   3   4   5   6   7   8   9
#
my @data = (
    [qw/G T R W/],
    [qw/G C H P M S V W/],
    [qw/C L T S G M/],
    [qw/J H D M W R F/],
    [qw/P Q L H S W F J/],
    [qw/P J D N F M S/],
    [qw/Z B D F G C S J/],
    [qw/R T B/],
    [qw/H N W L C/],
);

while(<>){
    my $line = $_;

    if($line =~ /^move (\d+) from (\d+) to (\d+)/ ){
        my $count = $1;
        my $from_index = $2 - 1;
        my $to_index = $3 - 1;

        for my $i (1..$count){
            my $from_item = pop @{$data[$from_index]};
            push @{$data[$to_index]}, $from_item;
        }
    }
}

for my $index (0..$#data) {
    print(pop(@{$data[$index]}));
}
print "\n";
