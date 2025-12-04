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

    my $zeros_hit = 0;
    ($current, $zeros_hit) = rotate($current, $dir, $num);
    if($zeros_hit > 0) {
        print "The dial is rotated $_ to point at $current, during this rotation it points at 0 $zeros_hit times\n";
    }
    else {
        print "The dial is rotated $_ to point at $current\n";
    }

    $password += $zeros_hit;
}

print "Password is $password\n";

sub rotate {
    my($current, $dir, $num) = @_;

    my $started_at_0 = $current == 0;

    my $zeros_hit = 0;

    $zeros_hit += int($num / 100);
    $num %= 100;

    if($num == 0) {
        return ($current, $zeros_hit);
    }

    if($dir eq 'L') {
        $current -= $num;
        if($current == 0) {
            $zeros_hit++;
        }
        elsif($current < 0) {
            $zeros_hit++ unless $started_at_0;
            $current += 100;
        }
    }
    else {
        $current += $num;
        if($current == 0) {
            $zeros_hit++;
        }
        elsif($current > 99) {
            $zeros_hit++;
            $current -= 100;
        }
    }

    return ($current, $zeros_hit);
}
