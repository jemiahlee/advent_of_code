#!/usr/bin/env perl

use warnings;
use strict;

my @data;

while(<>){
    chomp;
    push(@data, [split //]);
}

my $flash_count = 0;
my @octopi_to_flash;
for my $step (1..1000){
    excite_all();

    find_all_flashing_octopi();
    while(@octopi_to_flash){
        my $ref = shift(@octopi_to_flash);
        chain_react(@$ref);
        find_all_flashing_octopi();
    }

    set_negatives_back_to_zero();
    if(all_flashed()){
        print "Step $step has all flash.\n";
        print_data(); print "\n";
        last;
    }
}

print "Total flashes: $flash_count\n";

sub excite_all {
    for(my $i = 0; $i < @data; $i++){
        for(my $j = 0; $j < @{$data[$i]}; $j++){
            excite($i, $j);
        }
    }
}

sub find_all_flashing_octopi {
    for(my $i = 0; $i < @data; $i++){
        for(my $j = 0; $j < @{$data[$i]}; $j++){
            if($data[$i][$j] == 10){
                $data[$i][$j] = -1;
                push(@octopi_to_flash, [$i, $j]);
                $flash_count++;
            }
        }
    }
}

sub chain_react {
    my($i, $j) = @_;

    excite($i-1, $j-1);
    excite($i,   $j-1);
    excite($i+1, $j-1);
    excite($i-1, $j);
    excite($i+1, $j);
    excite($i-1, $j+1);
    excite($i,   $j+1);
    excite($i+1, $j+1);
}

sub excite {
    my($i, $j) = @_;

    return unless $i >= 0 and $j >= 0 and defined($data[$i][$j]);

    if($data[$i][$j] != -1){
        $data[$i][$j]++;
    }
}

sub set_negatives_back_to_zero {
    for(my $i = 0; $i < @data; $i++){
        for(my $j = 0; $j < @{$data[$i]}; $j++){
            if($data[$i][$j] == -1){
                $data[$i][$j] = 0;
            }
        }
    }
}

sub print_data {
    for(my $i = 0; $i < @data; $i++){
        print join('', @{$data[$i]}), "\n";
    }
}

sub all_flashed {
    for(my $i = 0; $i < @data; $i++){
        if('0' x 10 != join('', @{$data[$i]})){
            return 0;
        }
    }

    return 1;
}
