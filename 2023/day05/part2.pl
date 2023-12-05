#!/usr/bin/env perl

use warnings;
use strict;

my $seeds = <>;
chomp $seeds;
$seeds =~ s/^seeds:\s*//;

$/ = "\n\n";

my @map_list;

while(<>) {
    s/.*?map:\s*//;
    my @lines = split /\n/, $_;

    my %map;
    foreach my $line (@lines) {
        next if $line =~ /^\s*$/;
        my($destination_start, $source, $range) = split /\s+/, $line;
        $map{$source} = {destination_start => $destination_start, range => $range};
    }

    push @map_list, \%map;
}

my $lowest_value;

while($seeds =~ /(\d+) (\d+)/g) {
    foreach my $seed ($1..($1+$2)) {
        my $next_value = $seed;
        print "Examining seed $seed: ";

        foreach my $map (@map_list) {
            $next_value = find_next_value($next_value, $map);
        }

        print "$next_value\n";
        do { $lowest_value = $next_value; } unless defined($lowest_value);
        do { $lowest_value = $next_value; } if $next_value < $lowest_value;
    }
}

print "Lowest value found was $lowest_value\n";


sub find_next_value {
    my($value, $map) = @_;

    foreach my $key (keys %$map) {
        if($value >= $key and $value < ($key + $map->{$key}{range})) {
            my $difference_to_key = $value - $key;
            return $map->{$key}{destination_start} + $difference_to_key;
        }
    }

    return $value;
}
