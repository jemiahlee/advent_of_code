#!/usr/bin/env perl

use warnings;
use strict;

use Getopt::Long;
use Data::Dumper;
use List::Util qw/sum0/;

my $EXPANSION_FACTOR = 1;

GetOptions(
    'expansion-factor=i' => \$EXPANSION_FACTOR,
);

my @data;
while(<>) {
    chomp;

    push @data, [split //];
}

my @columns_to_repeat = find_expansion_columns();
my @rows_to_repeat = find_expansion_rows();

my @points = find_points();
add_expansion_factors();

my $sum = sum0 find_distances(\@points);
$sum /= 2;

print "Sum of distances is $sum\n";

sub find_expansion_columns {
    my @expansion_columns;

    COLUMN:
    for(my $col = 0; $col < scalar(@{$data[0]}); $col++) {
        for(my $row = 0; $row < scalar(@data); $row++) {
            next COLUMN if $data[$row][$col] ne '.';
        }
        push @expansion_columns, $col;
    }

    return @expansion_columns;
}

sub find_expansion_rows {
    my @expansion_rows;

    ROW:
    for(my $row = 0; $row < scalar(@data); $row++) {
        for(my $col = 0; $col < scalar(@{$data[$row]}); $col++) {
            next ROW if $data[$row][$col] ne '.';
        }
        push @expansion_rows, $row;
    }

    return @expansion_rows;
}

sub add_expansion_factors {
    foreach my $point (@points) {
        $point->{x_expansion_factor} = scalar(grep {$point->{x} > $_} @columns_to_repeat);
        $point->{y_expansion_factor} = scalar(grep {$point->{y} > $_} @rows_to_repeat);
    }
}

sub find_points {
    my @points;

    my $row_count = 0;
    my $point_count = 1;
    foreach my $row (@data) {
        my $line = join '', @{$row};
        while($line =~ /[#]/g) {
            push @points, {point => $point_count, x => $-[0], y => $row_count, score => $-[0] + $row_count};
            $point_count++;
        }
        $row_count++;
    }

    return @points;
}

sub find_distances {
    my $points = shift;

    my @distances;

    for(my $i = 0; $i < scalar(@{$points}); $i++) {
        for(my $j = 0; $j < scalar(@{$points}); $j++) {
            my $distance = compute_distance($points[$i], $points[$j]);
            print "Distance between point $points[$i]{point} and $points[$j]{point} is $distance\n";
            push @distances, $distance;
        }
    }

    return @distances;
}

sub compute_distance {
    my($point, $comparison_point) = @_;

    my $x = $point->{x} - $point->{x_expansion_factor} + $point->{x_expansion_factor} * $EXPANSION_FACTOR;
    my $y = $point->{y} - $point->{y_expansion_factor} + $point->{y_expansion_factor} * $EXPANSION_FACTOR;
    my $comparison_x = $comparison_point->{x} - $comparison_point->{x_expansion_factor} + $comparison_point->{x_expansion_factor} * $EXPANSION_FACTOR;
    my $comparison_y = $comparison_point->{y} - $comparison_point->{y_expansion_factor} + $comparison_point->{y_expansion_factor} * $EXPANSION_FACTOR;
    return abs($x - $comparison_x) + abs($y - $comparison_y);
}
