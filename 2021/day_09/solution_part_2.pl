#!/usr/bin/env perl

use warnings;
use strict;

my $verbose;
my @data;

while(<>){
    chomp;
    push(@data, [split //]);
}

my @processed;
for(my $i = 0; $i < @data; $i++){
    $processed[$i] = [];
}

my @basin_sizes;
for(my $i = 0; $i < @data; $i++){
    for(my $j = 0; $j < @{$data[$i]}; $j++){
        next if $processed[$i][$j];

        my $basin_size = determine_basin_size($i, $j);
        print "Found basin size of $basin_size at $i, $j\n" if $verbose;
        push(@basin_sizes, $basin_size) if $basin_size;
    }
}

print "Basins: @basin_sizes\n";
my @biggest_basins = (sort {$b <=> $a} @basin_sizes)[0..2];
print "Biggest basin sizes: ", join(', ', @biggest_basins), "\n";
print "Answer: ", $biggest_basins[0] * $biggest_basins[1] * $biggest_basins[2], "\n";

sub determine_basin_size {
    my($i, $j) = @_;

    print "Determining basin size for $i, $j\n" if $verbose;

    return 0 if $i < 0 or $j < 0 or not defined($data[$i][$j]) or $processed[$i][$j];

    $processed[$i][$j] = 1;  # only setting the processed flag when it is a valid grid entry

    return 0 if $data[$i][$j] == '9';

    return (1 + determine_basin_size($i,   $j-1)
              + determine_basin_size($i-1, $j)
              + determine_basin_size($i+1, $j)
              + determine_basin_size($i,   $j+1));
}
