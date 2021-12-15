#!/usr/bin/env perl

use warnings;
use strict;

my $NUMBER_OF_ITERATIONS = 10;
my $polymer = <>;
chomp $polymer;

my %rules;

while(<>){
    chomp;

    next unless /([A-Z]{2})\s*->\s*([A-Z])/;

    my($from, $to) = ($1, $2);

    $rules{$from} = $to;
}

# print "Template: $polymer\n";
for(my $i = 1; $i <= $NUMBER_OF_ITERATIONS; $i++){
    my $new_polymer = '';

    for(my $index = 0; $index < length($polymer)-1; $index++){
        my $first_letter = substr($polymer, $index, 1);
        my $second_letter = substr($polymer, $index+1, 1);

        $new_polymer .= $first_letter . $rules{"$first_letter$second_letter"};
    }

    $new_polymer .= substr($polymer, length($polymer)-1, 1);

    $polymer = $new_polymer;
    # print "After step $i: $polymer\n";
}

print "Answer: ", compute_answer(), "\n";

sub compute_answer {
    my %counter;
    map {$counter{$_}++} split //, $polymer;

    my $most_frequent_key = (sort {$counter{$b} <=> $counter{$a}} keys %counter)[0];
    print "Most frequent: $most_frequent_key ($counter{$most_frequent_key})\n";

    my $least_frequent_key = (sort {$counter{$a} <=> $counter{$b}} keys %counter)[0];
    print "Least frequent: $least_frequent_key ($counter{$least_frequent_key})\n";

    return $counter{$most_frequent_key} - $counter{$least_frequent_key};
}
