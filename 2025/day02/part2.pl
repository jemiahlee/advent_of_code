#!/usr/bin/perl

use warnings;
use strict;

$_ = <>;
chomp;

my $invalid_ids = 0;

while(m/(\d+)-(\d+)/g) {
    my($lower, $upper) = ($1, $2);

    for(my $i = $lower; $i <= $upper; $i++){
        if($i =~ /^(\d+)\1+$/){
            # print "$i is INVALID\n";
            $invalid_ids += $i;
        }
    }
}

print $invalid_ids, "\n";
