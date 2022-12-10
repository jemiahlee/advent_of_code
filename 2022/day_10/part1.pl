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


my @registers; # = splice(@input_instructions, -3, 3);
my $half_cycle = 1;
my $x = 1;

my $second_cycle = 0;

while(@input_instructions) {
    if(($half_cycle+20) % 40 == 0){
        my $answer = $half_cycle * $x;
        print "$half_cycle: \$x is $x, \$answer is $answer\n";
        push @answers, $answer;
    }

    if($second_cycle) {
        my $instruction = pop @input_instructions;
        if($instruction =~ /^addx (-?\d+)/) {
            $x += int($1);
        }
        $second_cycle = 0;
        next;
    };

    my $instruction = pop @input_instructions;
    print "Instruction (half-cycle $half_cycle): $instruction          \$x is $x\n";
    if($instruction =~ /^addx (-?\d+)/) {
        $second_cycle = 1;
        push @input_instructions, $instruction;
    }
} continue {
    $half_cycle++;
}

print join("\nAnswer: ", @answers), "\n";
print "Sum of all answers: ", sum(@answers), "\n";
