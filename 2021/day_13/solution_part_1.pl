#!/usr/bin/env perl

use warnings;
use strict;

my @data;

my $first_fold = 1;
while(<>){
    chomp;
    next unless /^fold along (x|y)=(\d+)|(\d+),(\d+)/;

    if(defined($3) and defined($4)){
        add_point($3, $4);
    }
    else {
        if($first_fold){
            $first_fold = 0;
            fill_zeroes();
        }
        print_matrix();
        print "Before folding $1=$2, point count: ", count_points(), "\n";
        fold($1, $2);
    }
}

print count_points(), "\n";

sub fold {
    my($axis, $line_number) = @_;
    my $x_axis_max = x_axis_max();

    if($axis eq 'x'){
        for(my $i = $line_number; $i < scalar(@data); $i++){
            my $row_count = $i - $line_number + 1;
            for(my $j = 0; $j < $x_axis_max; $j++) {
                $data[$i-$row_count][$j] += $data[$i][$j];
                $data[$i][$j] = 0;
            }
        }
    }
    elsif($axis eq 'y'){
        for(my $i = $line_number; $i < scalar(@data); $i++){
            my $row_count = $i - $line_number + 1;
            for(my $j = 0; $j < $x_axis_max; $j++) {
                $data[$i-$row_count][$j] += $data[$i][$j];
                $data[$i][$j] = 0;
            }
        }
    }

}

sub x_axis_max {
    return max(map {scalar(@{$_})} grep {defined} @data);
}

sub add_point {
    my($x, $y) = @_;
    $data[$x][$y]++;
}

sub print_matrix {
    for(my $i = 0; $i < x_axis_max(); $i++){
        foreach my $row (@data){
            print $row->[$i] ? '#' : '.';
        }
        print "\n";
    }
}

sub fill_zeroes {
    my $max_x = max(map {scalar(@{$_})} grep {defined} @data);

    for(my $i = 0; $i < @data; $i++){
        for(my $j = 0; $j < $max_x; $j++){
            $data[$i][$j] = 0 unless $data[$i][$j];
        }
    }
}

sub max {
    return (sort {$b <=> $a} @_)[0];
}

sub count_points {
    my $points = 0;

    my $max_x = max(map {scalar(@{$_})} grep {defined} @data);
    print "Max x is $max_x\n";
    for(my $i = 0; $i < @data; $i++){
        for(my $j = 0; $j < $max_x; $j++){
            $points++ if $data[$i][$j] > 0;
        }
    }

    return $points;
}
