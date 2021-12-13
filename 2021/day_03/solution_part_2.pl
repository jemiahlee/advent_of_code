#!/usr/bin/env perl

use warnings;
use strict;

undef $/;
$_ = <>;

my(@numbers) = split /\n/;

my $oxygen_rating = sieve('ones');
my $co2_rating = sieve('zeroes');

print "Oxygen rating: $oxygen_rating\nCO2 Rating: $co2_rating\nMultiplied: ", $oxygen_rating * $co2_rating, "\n";

sub do_process {
    my $digit_to_look_for = shift;
    my @ratings = @numbers;

    foreach my $digit (0..11){
        last if scalar(@ratings) == 1;

        my($zeroes, $ones) = bit_counting(\@ratings, $digit);
        for my $number (@numbers){
            if($zeroes > $ones and split(//, $number)[$digit] == '0'){

            }
        }
    }

    return $ratings[0];
}

sub winning_bit {
    my($arr_ref, $bit) = @_;

    my $zeroes = 0;
    my $ones = 0;

    for my $number (@$arr_ref){
        if(split(//, $number)[$bit] == '1'){
            $ones++;
        }
        else {
            $zeroes++;
        }
    }

    return ($zeroes, $ones);
}
