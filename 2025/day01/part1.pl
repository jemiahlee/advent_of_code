#!/usr/bin/perl

use warnings;
use strict;

my $current = 50;
my $password = 0;

print "The dial starts by pointing at $current\n";
while(<>){
    chomp;
    m/^([LR])(\d+)$/ or die "did not match correctly: $.";
    my($dir, $num) = ($1, $2);

    $current = rotate($current, $dir, $num);
    print "The dial is rotated $_ to point at $current\n";

    if($current == 0) {
        $password++;
        print "Since it is 0, adding one to the password, which is now $password\n";
    }
}

print "Password is $password\n";

sub rotate {
    my($current, $dir, $num) = @_;

    $num %= 100;

    if($dir eq 'L') {
        $current -= $num;
        if($current < 0) {
            $current += 100;
        }
    }
    else {
        $current += $num;
        if($current > 99) {
            $current -= 100;
        }
    }

    return $current;
}
