#!/usr/bin/env perl

use warnings;
use strict;

my @data;

while(<>){
    chomp;
    push(@data, [split //]);
}

my $sum = 0;
for(my $i = 0; $i < @data; $i++){
    for(my $j = 0; $j < @{$data[$i]}; $j++){
        if(is_low_point($i, $j)){
            print "Low: $i, $j\n";
            $sum += 1 + $data[$i][$j];
        }
    }
}

print $sum, "\n";

sub is_low_point {
    my($i, $j) = @_;

    return (is_lower_than_adjacent($data[$i][$j], $i,   $j-1) and
           is_lower_than_adjacent($data[$i][$j], $i-1, $j) and
           is_lower_than_adjacent($data[$i][$j], $i+1, $j) and
           is_lower_than_adjacent($data[$i][$j], $i,   $j+1));
}

sub is_lower_than_adjacent {
    my($value, $i, $j) = @_;

    if($i < 0 or $j < 0 or not defined($data[$i][$j]) or $value < $data[$i][$j]){
        return 1;
    }

    return 0;
}
