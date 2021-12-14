#!/usr/bin/env perl

use warnings;
use strict;

undef $/;
$_ = <>;

my @crabs = split /,/;
my $number_of_crabs = scalar(@crabs);

my %crabs;
for my $crab (@crabs){
    $crabs{$crab}++;
}

my $median_count = int($number_of_crabs / 2);
my $count;
my @sorted_crabs = sort {$a <=> $b} keys %crabs;
my $median;

for my $crab (@sorted_crabs) {
    $count += $crabs{$crab};

    if($count >= $median_count){
        $median = $crab;
        last;
    }
}

print "median is $median\n";

my $low = $sorted_crabs[0];
my $high = $sorted_crabs[1];

my %differences;
$differences{$low} = compute_difference($low);
$differences{$high} = compute_difference($high);
$differences{$median} = compute_difference($median);

for my $i ($low..$high){
    $differences{$i} = compute_difference($i);
}

my $lowest = (sort {$differences{$a} <=> $differences{$b}} keys %differences)[0];
print "Lowest spend is: ", $differences{$lowest}, "\n";

sub compute_difference {
    my $target = shift;

    my $difference = 0;
    for my $crab (@sorted_crabs){
        my $l_difference = abs($target - $crab) * $crabs{$crab};
        $difference += $l_difference;
    }

    return $difference;
}
