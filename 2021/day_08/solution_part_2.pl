#!/usr/bin/env perl

use warnings;
use strict;

my %digits = (
    'cf' => 1,
    'acdeg' => 2,
    'acdfg' => 3,  # 1 7
    'bcdf' => 4,  # 1
    'abdfg' => 5,
    'abdefg' => 6,
    'acf' => 7,   # 1
    'abcdefg' => 8,
    'abcdfg' => 9,  # 1 4 7
    'abcefg' => 0,  # 1 7
);

my $sum = 0;
while(<>){
    chomp;

    my @wires = sort_wires($_);
    # print join('-', @wires), "\n";

    my %numbers;

    foreach my $number (@wires[0..9]){

        if(length($number) == 7){
            $numbers{$number} = 8;
            $numbers{8} = $number;
        }
        elsif(length($number) == 2){
            $numbers{$number} = 1;
            $numbers{1} = $number;
        }
        elsif(length($number) == 3){
            $numbers{$number} = 7;
            $numbers{7} = $number;
        }
        elsif(length($number) == 4){
            $numbers{$number} = 4;
            $numbers{4} = $number;
        }
    }

    foreach my $number (@wires[0..9]){
        next if defined($numbers{$number});

        if(contains($number, $numbers{1}) and contains($number, $numbers{4}) and contains($number, $numbers{7})){
            $numbers{$number} = 9;
            $numbers{9} = $number;
        }
        elsif(length($number) == 6 and contains($number, $numbers{1})){
            $numbers{$number} = 0;
        }
        elsif(length($number) == 6){
            $numbers{$number} = 6;
        }
        elsif(length($number) == 5 and contains($number, $numbers{7})){
            $numbers{$number} = 3;
        }
    }

    foreach my $number (@wires[0..9]){
        next if defined($numbers{$number});

        if(contains($numbers{9}, $number)){
            $numbers{$number} = 5;
        }
        else {
            $numbers{$number} = 2;
        }
    }

    my $final_number = '';
    foreach my $number (@wires[11..14]){
        $final_number .= $numbers{$number};
    }

    print "Number was $final_number\n";
    $sum += $final_number;
}

print "$sum\n";


sub sort_wires {
    my $wires = shift;

    my @wires;
    foreach my $number (split(/\s+/, $wires)){
        push(@wires, join('', sort split(//, $number)));
    }

    return @wires;
}

sub contains {
    my($number, $pattern) = @_;

    my(@individual_numbers) = (split //, $pattern);

    foreach my $individual_number (@individual_numbers){
        return 0 unless $number =~ /$individual_number/;
    }

    return 1;
}
