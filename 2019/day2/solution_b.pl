#!/usr/bin/perl

use strict;
use warnings;

my $TARGET_VALUE = 19690720;

my @input_array;
while( <> ) {
    chomp;

    my @pieces = split /,/, $_;
    push @input_array, @pieces;
}

foreach my $noun (0..99) {
    foreach my $verb (reverse(0..99)) {
        $input_array[1] = $noun;
        $input_array[2] = $verb;

        my @new_array;
        push @new_array, @input_array;

        if (operate(\@new_array) == $TARGET_VALUE) {
            print "Got an answer of ", $noun * 100 + $verb, "\n";
            exit;
        }
    }
}

print "Finished processing and did not find a solution!\n";


sub operate {
    my $input_array = shift;

    my $instruction_offset = 0;
    while(1) {
        my $instruction = $input_array->[$instruction_offset * 4];
        last if $instruction == 99;

        my($first_operand, $second_operand, $result_location) = @{$input_array}[($instruction_offset * 4 + 1)..($instruction_offset * 4 + 3)];

        # print "Instruction: $instruction, First: $first_operand ($input_array->[$first_operand]), Second: $input_array->[$second_operand], Result: $result_location\n";

        if( $instruction == 1 ) {
            $input_array->[$result_location] = $input_array->[$first_operand] + $input_array->[$second_operand];
            # print "Changing index $result_location to be $input_array[$result_location]\n";
        }
        elsif( $instruction == 2 ) {
            $input_array->[$result_location] = $input_array->[$first_operand] * $input_array->[$second_operand];
            # print "Changing index $result_location to be $input_array[$result_location]\n";
        }
        else {
            die "Got a bad instruction: $instruction\n;"
        }
    } continue {
        $instruction_offset++;
    }

    return $input_array->[0];
}
