#!/usr/bin/env perl

use warnings;
use strict;

use Data::Dumper;

my %struct;
my $root_struct = \%struct;
$root_struct->{'__PREVIOUS__'} = $root_struct;
$root_struct->{'__LOCAL_SIZE__'} = 0;
$root_struct->{'__TOTAL_SIZE__'} = 0;
$root_struct->{'__NAME__'} = '/';
my $struct = \%struct;

my $DISK_SIZE = 70_000_000;
my $TOTAL_SIZE_NEEDED = 30_000_000;

while(<>) {

    if(m{^\$ cd /}) {
        $struct = $root_struct;
    }
    elsif(/^\$ cd [.]{2}/) {
        $struct = $struct->{'__PREVIOUS__'};
    }
    elsif(/^\$ cd (\S+)/) {
        die unless ref $struct->{$1};
        $struct = $struct->{$1};
        $struct->{'__NAME__'} = $1;
    }
    elsif(/^(\d+) (\S+)/){
        $struct->{$2} = $1;
        $struct->{'__LOCAL_SIZE__'} += $1;
        $struct->{'__TOTAL_SIZE__'} += $1;

        my $temp_struct = $struct;
        while($temp_struct != $root_struct){
            $temp_struct = $temp_struct->{'__PREVIOUS__'};
            $temp_struct->{'__TOTAL_SIZE__'} += $1;
        }
    }
    elsif(/^dir (\S+)/){
        $struct->{$1} = {};
        $struct->{$1}{'__PREVIOUS__'} = $struct;
        $struct->{$1}{'__LOCAL_SIZE__'} = 0;
        $struct->{$1}{'__TOTAL_SIZE__'} = 0;
    }
}

print STDERR "Root structure size: $root_struct->{'__TOTAL_SIZE__'}\n";
my $FREE_SPACE = $DISK_SIZE - $root_struct->{'__TOTAL_SIZE__'};
print STDERR "Free space: $FREE_SPACE\n";
my $SPACE_NEEDED_TO_FREE = $TOTAL_SIZE_NEEDED - $FREE_SPACE;
print STDERR "Space needed, at least $SPACE_NEEDED_TO_FREE\n";
$struct = $root_struct;
my $answer_size = 70_000_000;
my $answer_dir = '';
print_structure($struct, 0);

print "Delete directory $answer_dir to save $answer_size bytes.\n";

sub print_structure {
    my $struct = shift;
    my $depth = shift;

    print '  ' x ($depth), "- $struct->{'__NAME__'} (total_size=$struct->{'__TOTAL_SIZE__'})\n";

    if($struct->{'__TOTAL_SIZE__'} > $SPACE_NEEDED_TO_FREE and $struct->{'__TOTAL_SIZE__'} < $answer_size){
        $answer_dir = $struct->{'__NAME__'};
        $answer_size = $struct->{'__TOTAL_SIZE__'};
    }

    $depth++;

    my @directories;
    foreach my $key (sort keys %$struct) {
        next if $key =~ /^__/;

        if(ref $struct->{$key}) {
            push @directories, $key;
        }
        else {
            print '  ' x $depth, "$key (file, size=$struct->{$key})\n";
        }
    }

    foreach my $directory (sort @directories) {
        print_structure($struct->{$directory}, $depth);
    }
}

sub print_structure2 {
    my $struct = shift;

    print "$struct->{'__TOTAL_SIZE__'}: $struct->{'__NAME__'}\n";

    my @directories;
    foreach my $key (sort keys %$struct) {
        next if $key =~ /^__/; #need to skip the PREVIOUS reference

        if(ref $struct->{$key}) {
            push @directories, $key;
        }
    }

    return unless @directories;

    my $directories_less_than_count = 0;
    for my $directory (sort @directories){
        print_structure($struct->{$directory});
    }
}
