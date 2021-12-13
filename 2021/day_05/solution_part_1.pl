#!/usr/bin/env perl

use warnings;
use strict;

my $size = 1000;
my @data;

for(my $i = 0; $i < $size; $i++){
    for(my $j = 0; $j < $size; $j++){
        $data[$i][$j] = 0;
    }
}

while(<>){
    chomp;

    next unless /(\d+),(\d+)\s*->\s*(\d+),(\d+)/;
    my($x1, $y1, $x2, $y2) = ($1, $2, $3, $4);

    next unless ($x1 == $x2 or $y1 == $y2);

    if($x1 == $x2){
        my($ylower) = min($y1, $y2);
        my($yupper) = max($y1, $y2);

        for my $y ($ylower..$yupper){
            $data[$x1][$y]++;
        }
    }
    else {
        my($xlower) = min($x1, $x2);
        my($xupper) = max($x1, $x2);

        for my $x ($xlower..$xupper){
            $data[$x][$y1]++;
        }
    }
}

print_matrix();
print count_intersections(), "\n";

sub print_matrix {
    foreach my $x (@data){
        print join(' ', map {$_ || '0'} @{$x}), "\n";
    }
}

sub max {
    my($x, $y) = @_;

    return $x if $x > $y;
    return $y;
}

sub min {
    my($x, $y) = @_;

    return $x if $x < $y;
    return $y;
}

sub count_intersections {
    my $intersections = 0;

    for(my $i = 0; $i < @data; $i++){
        for(my $j = 0; $j < @{$data[$i]}; $j++){
            $intersections++ if $data[$i][$j] > 1;
        }
    }

    return $intersections;
}
