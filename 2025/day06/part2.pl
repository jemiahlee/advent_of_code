#!/usr/bin/perl

use warnings;
use strict;

use FileHandle;

my $fh = FileHandle->new;
my $filename = shift;
$fh->open("< $filename");

my @lastline;
my $lastline;
my $last_line_number = 0;

while(<$fh>){
    chomp;

    $lastline = $_;
    @lastline = split /\s+/;
    $last_line_number++;
}

my $all_data = [];
for(my $col_number = 0; $col_number < scalar(@lastline); $col_number++) {
    $fh->seek(0, 0);
    my $line_number = 0;

    while(<$fh>){
        chomp;

        last if $line_number++ == $last_line_number - 1;

        my($this_column) = (split /\b\s+\b/)[$col_number];
        my @these_nums = reverse(split //, $this_column);
        for(my $i = 0; $i < scalar(@these_nums); $i++) {
            $all_data->[$i][$col_number] ||= '';
            $all_data->[$i][$col_number] .= $these_nums[$i];
        }
    }
}

foreach my $row (@$all_data) {
    print(join(' ', @$row), "\n");
}
print $lastline, "\n";
