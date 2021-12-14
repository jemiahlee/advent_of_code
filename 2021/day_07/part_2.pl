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
my $high = $sorted_crabs[-1];

my @triangulars = make_triangulars($high);
$count = 0;
for my $t (@triangulars) {
    print "$count: $t\n";
    $count++;
}

my %differences;
for my $i ($low..$high){
    $differences{$i} = compute_fuel_difference($i);
}

my $lowest = (sort {$differences{$a} <=> $differences{$b}} keys %differences)[0];
print "Lowest spend is: ", $differences{$lowest}, "\n";

sub compute_fuel_difference {
    my $target = shift;

    my $difference = 0;
    for my $crab (@sorted_crabs){
        my $fuel_cost = $triangulars[abs($target - $crab)];
        my $l_difference =  $fuel_cost * $crabs{$crab};
        $difference += $l_difference;
    }

    return $difference;
}

sub make_triangulars {
    my $max = shift;
    print "Making triangulars using max of $max\n";

    my @numbers;

    my $gathered_sum = 0;
    for my $i (1..$max+1){
        push(@numbers, $gathered_sum);
        $gathered_sum += $i;
    }

    return @numbers;
}
