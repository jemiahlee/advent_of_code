#!/usr/bin/env perl

use warnings;
use strict;

undef $/;
$_ = <>;

my @input = generate_input_array($_);

for my $i (1..256) {
    @input = breed(\@input);
}

my $sum;
map { $sum += $_ } @input;
print "Sum: $sum\n";

sub generate_input_array {
    my $input = shift;
    chomp $input;

    my @arr;

    map { $arr[$_]++ } grep /\d/, split /,/, $input;

    return @arr;
}

sub breed {
    my $arr_ref = shift;

    my @new_arr;

    $new_arr[8] = $arr_ref->[0];
    $new_arr[7] = ($arr_ref->[8] || 0);
    $new_arr[6] = ($arr_ref->[0] || 0) + ($arr_ref->[7] || 0);
    $new_arr[5] = $arr_ref->[6];
    $new_arr[4] = $arr_ref->[5];
    $new_arr[3] = $arr_ref->[4];
    $new_arr[2] = $arr_ref->[3];
    $new_arr[1] = $arr_ref->[2];
    $new_arr[0] = $arr_ref->[1];

    return @new_arr;
}
