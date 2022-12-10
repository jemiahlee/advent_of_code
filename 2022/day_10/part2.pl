#!/usr/bin/env perl

use warnings;
use strict;

use List::Util qw/sum/;

my @input_instructions;

my @answers;

while(<>) {
    chomp;
    unshift @input_instructions, $_;
}

my $half_cycle = 1;
my $x = 1;

my $current_instruction = '';
my $second_cycle = 0;

# Start cycle   3: begin executing addx -11
# During cycle  3: CRT draws pixel in position 2
# Current CRT row: ##.

my @crt_rows;
my @current_crt_row;

my $verbose = 1;

while(@input_instructions) {
    if($half_cycle % 40 == 1){
        push @crt_rows, join('', @current_crt_row);
        @current_crt_row = ();
    }

    if($current_instruction !~ /^addx/){
        $current_instruction = pop @input_instructions;
        print "Start of cycle   $half_cycle: begin executing $current_instruction\n" if $verbose;
    }

    if(abs(($half_cycle % 40) - $x -1) <= 1 ) {
        print "During cycle     $half_cycle: CRT draws pixel (#) in position ", ($half_cycle % 40)-1, "(Register X is $x)\n" if $verbose;
        push @current_crt_row, '#';
    }
    else {
        print "During cycle     $half_cycle: CRT draws pixel (.) in position ", ($half_cycle % 40)-1, " (Register X is $x)\n" if $verbose;
        push @current_crt_row, '.';
    }

    print 'Current CRT row: ', join('', @current_crt_row), "\n" if $verbose;

    if($second_cycle && $current_instruction =~ /^addx (-?\d+)/){
        $x += int($1);
        print "End of cycle     $half_cycle: finish executing addx $1 (Register X is now $x)\n\n" if $verbose;
        $current_instruction = '';
        $second_cycle = 0;
    }
    elsif($current_instruction =~ /^addx (-?\d+)/){
        $second_cycle = 1;
        print "\n" if $verbose;
    }
    else {
        print "End of cycle  $half_cycle: finish executing noop\n\n" if $verbose;
    }
} continue {
    $half_cycle++;
}

foreach my $row (@crt_rows) {
    print $row, "\n";
}
print join('', @current_crt_row), "\n";
