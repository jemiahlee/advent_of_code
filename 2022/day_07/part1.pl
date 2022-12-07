#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;

my $root_struct = {};
$root_struct->{'__PREVIOUS__'} = $root_struct;
$root_struct->{'__NAME__'} = '/';

my $struct = $root_struct;

my $SIZE = 100_000;

while(<>) {

    print;

    if(m{^\$ cd /}) {
        $struct = $root_struct;
    }
    elsif(/^\$ cd [.]{2}/) {
        $struct = $struct->{'__PREVIOUS__'};
    }
    elsif(/^\$ cd (\S+)/) {
        die unless ref $struct->{$1};
        $struct = $struct->{$1};
    }
    elsif(/^(\d+) (\S+)/){
        $struct->{$2} = $1;
        $struct->{'__SIZE__'} += $1;
    }
    elsif(/^dir (\S+)/){
        $struct->{$1} = {};
        $struct->{$1}{'__PREVIOUS__'} = $struct;
        $struct->{$1}{'__SIZE__'} = 0;
        $struct->{$1}{'__NAME__'} = $1;
    }
}

$struct = $root_struct;

my $total_sum = 0;
print_structure($struct, 0, 0);

print "Total size: $total_sum\n";

sub print_structure {
    my $struct = shift;
    my $depth = shift;
    my $sum = shift;

    print '  ' x ($depth), "- $struct->{'__NAME__'}\n";

    $depth++;

    my @directories;
    foreach my $key (sort keys %$struct) {
        next if $key =~ /^__/;

        if(ref $struct->{$key}) {
            push @directories, $key;
        }
        else {
            print '  ' x ($depth+1), "$key (file, size=$struct->{$key})\n";
        }
    }

    my $local_total = $struct->{'__SIZE__'};
    foreach my $directory (sort @directories) {
        my $size = print_structure($struct->{$directory}, $depth, $sum);

        $local_total += $size;
    }

    if($local_total <= $SIZE){
        $total_sum += $local_total;
        return $local_total;
    }

    return $SIZE+1;
}
