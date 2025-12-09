#!/usr/bin/perl

use warnings;
use strict;

use FileHandle;

my $fh = FileHandle->new;
my $filename = shift;
$fh->open("< $filename");

my @lastline;
my $lastline;
my $linecount = 0;

while(<$fh>){
    chomp;
    s/^\s+//;

    $lastline = $_;
    @lastline = split /\s+/;
    $linecount++;
}

$fh->seek(0, 0);

my @data;
my $second_line_count = 0;
while(<$fh>){
    chomp;
    s/^\s+//;

    last if $second_line_count == $linecount - 1;

    if($second_line_count++ == 0) {
        # this is the first line, don't do the operation.
        push @data, split /\s+/;
    }
    else {
        my @linedata = split /\s+/;
        for(my $i = 0; $i < scalar(@linedata); $i++) {
            $data[$i] = eval("$data[$i] $lastline[$i] $linedata[$i]");
        }
    }
}

my $totalsum = 0;
foreach my $number (@data) {
    print "$number\n";
    $totalsum += $number;
}


print "Total: $totalsum\n";

